#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const args = process.argv.slice(2);

function option(name, fallback = null) {
  const index = args.indexOf(name);
  return index === -1 ? fallback : args[index + 1] ?? fallback;
}

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function walkTokens(value, parts = [], result = []) {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return result;
  if ('$value' in value && '$type' in value) {
    result.push({ path: parts.join('/'), token: value });
    return result;
  }
  for (const [key, child] of Object.entries(value)) walkTokens(child, [...parts, key], result);
  return result;
}

function filesUnder(directory) {
  return fs.readdirSync(directory).filter((file) => file.endsWith('.json')).sort()
    .map((file) => path.join(directory, file));
}

function canonical(value) {
  const number = (item) => Math.round(Number(item) * 1000000) / 1000000;
  if (value && typeof value === 'object' && !Array.isArray(value)) {
    if (Array.isArray(value.components) && 'alpha' in value) {
      return { kind: 'color', components: value.components.map(number), alpha: number(value.alpha) };
    }
    if (['r', 'g', 'b'].every((key) => key in value)) {
      return { kind: 'color', components: [value.r, value.g, value.b].map(number), alpha: number(value.a ?? 1) };
    }
    if ('value' in value && value.unit === 'px' && Object.keys(value).length <= 2) return canonical(value.value);
  }
  return normalize(value);
}

function normalize(value) {
  if (value && typeof value === 'object' && !Array.isArray(value)) {
    if (value.type === 'VARIABLE_ALIAS') {
      return { alias: value.id, name: value.name ?? null, resolved: normalize(value.resolved) };
    }
    const entries = Object.entries(value).sort(([a], [b]) => a.localeCompare(b));
    return Object.fromEntries(entries.map(([key, item]) => [key, normalize(item)]));
  }
  if (Array.isArray(value)) return value.map(normalize);
  return value;
}

function tokenValue(token) {
  return canonical(token.$value);
}

function tokenIndex(config) {
  const records = [];
  const layers = [
    ['primitive', config.primitiveTokenPaths],
    ['semantic', config.semanticTokenPaths],
  ];
  for (const [layer, directories] of layers) {
    for (const directory of directories) for (const file of filesUnder(path.resolve(root, directory))) {
      const mode = path.basename(file).toLowerCase().includes('dark') ? 'Dark'
        : path.basename(file).toLowerCase().includes('light') ? 'Light' : 'Default';
      for (const { path: tokenPath, token } of walkTokens(readJson(file))) {
        const extensions = token.$extensions ?? {};
        const alias = extensions['com.figma.aliasData'] ?? null;
        records.push({
          layer,
          file: path.relative(root, file),
          path: tokenPath,
          mode,
          type: token.$type,
          value: tokenValue(token),
          variableId: extensions['com.figma.variableId'] ?? null,
          alias: alias ? {
            targetVariableId: alias.targetVariableId ?? null,
            targetVariableName: alias.targetVariableName ?? null,
          } : null,
        });
      }
    }
  }
  const byPath = new Map(records.map((record) => [record.path, record]));
  const resolving = new Set();
  function resolveTokenAlias(record) {
    if (typeof record.value !== 'string' || !record.value.startsWith('{') || !record.value.endsWith('}')) return record.value;
    const rawTargetPath = record.value.slice(1, -1);
    const targetPath = byPath.has(rawTargetPath) ? rawTargetPath : rawTargetPath.replace(/\./g, '/');
    if (resolving.has(targetPath)) return { aliasCycle: targetPath };
    const target = byPath.get(targetPath);
    if (!target) return record.value;
    resolving.add(targetPath);
    const resolved = resolveTokenAlias(target);
    resolving.delete(targetPath);
    return resolved;
  }
  for (const record of records) record.value = canonical(resolveTokenAlias(record));
  return records;
}

function snapshotIndex(snapshot) {
  return snapshot.collections.flatMap((collection) => collection.variables.map((variable) => ({
    ...variable,
    collectionId: collection.id,
    collectionName: collection.name,
    modes: Object.fromEntries(collection.modes.map((mode) => [mode.id, mode.name])),
  })));
}

function comparable(variable, modeId, variablesById, seen = new Set()) {
  const value = variable.valuesByMode?.[modeId] ?? Object.values(variable.valuesByMode ?? {})[0];
  if (value?.type === 'VARIABLE_ALIAS') {
    if (seen.has(value.id)) return { aliasCycle: value.id };
    const target = variablesById.get(value.id);
    if (!target) return { missingAlias: value.id };
    const nextSeen = new Set(seen);
    nextSeen.add(value.id);
    return comparable(target, modeId, variablesById, nextSeen);
  }
  return canonical(value);
}

function compare(snapshot, config) {
  const figma = snapshotIndex(snapshot);
  const tokens = tokenIndex(config);
  const byId = new Map(figma.map((item) => [item.id, item]));
  const byName = new Map(figma.map((item) => [item.name, item]));
  const used = new Set();
  const result = { matched: [], changed: [], missingInFigma: [], figmaOnly: [], errors: [] };

  for (const token of tokens) {
    const variable = (token.variableId && byId.get(token.variableId)) || byName.get(token.path);
    if (!variable) {
      result.missingInFigma.push(token);
      continue;
    }
    used.add(variable.id);
    const modeId = Object.entries(variable.modes).find(([, name]) => name === token.mode)?.[0]
      ?? Object.keys(variable.valuesByMode ?? {})[0];
    const expected = token.value;
    const actual = comparable(variable, modeId, byId);
    const item = { token, figma: { id: variable.id, name: variable.name, mode: variable.modes[modeId], value: actual } };
    const sameType = (token.type === 'string' && variable.resolvedType === 'STRING')
      || (token.type === 'number' && variable.resolvedType === 'FLOAT')
      || (token.type === 'color' && variable.resolvedType === 'COLOR')
      || (['dimension', 'number'].includes(token.type) && variable.resolvedType === 'FLOAT');
    if (sameType && JSON.stringify(expected) === JSON.stringify(actual)) result.matched.push(item);
    else result.changed.push({ ...item, reasons: {
      type: sameType ? null : 'type-mismatch',
      value: JSON.stringify(expected) === JSON.stringify(actual) ? null : 'value-mismatch',
    }});
  }

  for (const variable of figma) if (!used.has(variable.id)) result.figmaOnly.push({
    id: variable.id, name: variable.name, collection: variable.collectionName,
  });
  return result;
}

function display(value) {
  return JSON.stringify(value) ?? '—';
}

function markdownReport(report) {
  const comparison = report.comparison;
  const issueCount = comparison.changed.length + comparison.missingInFigma.length;
  const status = issueCount === 0 ? 'PASS — ไม่พบ drift ใน token ที่อยู่ใน scope' : `ATTENTION — พบความผิดปกติ ${issueCount} รายการ`;
  const lines = [
    '# Figma Local Variables Token Audit', '',
    `- วันที่ตรวจ: ${report.generatedAt}`,
    `- Snapshot: \`${report.snapshot}\``,
    `- Scope: \`${report.scope.join('`, `')}\``,
    `- สถานะ: **${status}**`, '',
    '## สรุป', '',
    '| รายการ | จำนวน | ความหมาย |', '|---|---:|---|',
    `| Matched | ${comparison.matched.length} | ตรงกัน |`,
    `| Changed | ${comparison.changed.length} | token ใน Flutter มีคู่ใน Figma แต่ค่า/type/mode ไม่ตรง |`,
    `| Missing in Figma | ${comparison.missingInFigma.length} | token ใน Flutter ไม่มีใน snapshot Figma |`,
    `| Figma-only | ${comparison.figmaOnly.length} | มีใน Figma แต่ยังไม่อยู่ใน Flutter scope; ไม่ใช่ error อัตโนมัติ |`, '',
  ];
  if (comparison.changed.length) {
    lines.push('## จุดที่ต้องตรวจแก้', '', '| Layer | Token | Flutter file | Mode | ปัญหา | Flutter value | Figma value |', '|---|---|---|---|---|---|---|');
    for (const item of comparison.changed) {
      const reasons = Object.values(item.reasons).filter(Boolean).join(', ');
      lines.push(`| ${item.token.layer} | \`${item.token.path}\` | \`${item.token.file}\` | ${item.token.mode} | ${reasons} | \`${display(item.token.value)}\` | \`${display(item.figma.value)}\` |`);
    }
    lines.push('');
  }
  if (comparison.missingInFigma.length) {
    lines.push('## Token ที่ไม่มีใน Figma', '', '| Layer | Token | Flutter file |', '|---|---|---|');
    for (const item of comparison.missingInFigma) lines.push(`| ${item.layer} | \`${item.path}\` | \`${item.file}\` |`);
    lines.push('');
  }
  lines.push('## Figma-only inventory', '', 'รายการเหล่านี้ยังไม่ถูกเลือกมาใช้ใน Flutter จึงไม่ถือเป็น drift โดยอัตโนมัติ', '', '| Collection | Variable | ID |', '|---|---|---|');
  for (const item of comparison.figmaOnly) lines.push(`| ${item.collection} | \`${item.name}\` | \`${item.id}\` |`);
  lines.push('');
  return lines.join('\n');
}

const snapshotFile = option('--snapshot');
if (!snapshotFile) {
  console.error('Usage: node scripts/figma-token-audit.mjs --snapshot <path> [--config <path>] [--out <path>] [--md-out <path>]');
  process.exit(2);
}
const configFile = option('--config');
const config = configFile ? readJson(configFile) : {
  framework: 'flutter',
  primitiveTokenPaths: ['lib/config/themes/v3/tokens/primitive/'],
  semanticTokenPaths: ['lib/config/themes/v3/tokens/semantic/'],
};
if (!Array.isArray(config.primitiveTokenPaths) || !Array.isArray(config.semanticTokenPaths)) {
  console.error('Config must define primitiveTokenPaths and semanticTokenPaths arrays');
  process.exit(2);
}
const report = {
  schemaVersion: 1,
  generatedAt: new Date().toISOString(),
  snapshot: path.relative(root, path.resolve(snapshotFile)),
  framework: config.framework ?? 'unknown',
  scope: [...config.primitiveTokenPaths, ...config.semanticTokenPaths],
  comparison: compare(readJson(snapshotFile), config),
};
const output = JSON.stringify(report, null, 2) + '\n';
const outputFile = option('--out');
if (outputFile) fs.writeFileSync(outputFile, output);
else process.stdout.write(output);
const markdownFile = option('--md-out', outputFile ? outputFile.replace(/\.json$/i, '.md') : null);
if (markdownFile) fs.writeFileSync(markdownFile, markdownReport(report));
