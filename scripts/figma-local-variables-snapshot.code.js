// Run this read-only code through the figma-use tool with fileKey
// `mhUvPg9tOjlvQvEW6glQhJ` and save the returned JSON as a dated snapshot.
const collections = await figma.variables.getLocalVariableCollectionsAsync();
const variables = await figma.variables.getLocalVariablesAsync();
const byId = new Map(variables.map((variable) => [variable.id, variable]));

function normalizeValue(value, seen = new Set()) {
  if (!value || value.type !== 'VARIABLE_ALIAS') return value;
  if (seen.has(value.id)) return { type: 'VARIABLE_ALIAS', id: value.id, cycle: true };
  const target = byId.get(value.id);
  if (!target) return { type: 'VARIABLE_ALIAS', id: value.id, missing: true };
  const nextSeen = new Set(seen);
  nextSeen.add(value.id);
  return {
    type: 'VARIABLE_ALIAS',
    id: value.id,
    name: target.name,
    resolved: Object.fromEntries(
      Object.entries(target.valuesByMode).map(([modeId, modeValue]) => [
        modeId,
        normalizeValue(modeValue, nextSeen),
      ]),
    ),
  };
}

return {
  schemaVersion: 1,
  source: {
    provider: 'figma',
    fileKey: figma.fileKey,
    referenceNodeId: '596:1097',
    capturedAt: new Date().toISOString(),
  },
  collections: collections
    .slice()
    .sort((a, b) => a.name.localeCompare(b.name) || a.id.localeCompare(b.id))
    .map((collection) => ({
      id: collection.id,
      name: collection.name,
      hiddenFromPublishing: collection.hiddenFromPublishing,
      defaultModeId: collection.defaultModeId,
      modes: collection.modes
        .map((mode) => ({ id: mode.modeId, name: mode.name }))
        .sort((a, b) => a.id.localeCompare(b.id)),
      variables: collection.variableIds
        .map((id) => byId.get(id))
        .filter(Boolean)
        .sort((a, b) => a.name.localeCompare(b.name) || a.id.localeCompare(b.id))
        .map((variable) => ({
          id: variable.id,
          name: variable.name,
          resolvedType: variable.resolvedType,
          scopes: [...variable.scopes].sort(),
          hiddenFromPublishing: variable.hiddenFromPublishing,
          codeSyntax: variable.codeSyntax,
          valuesByMode: Object.fromEntries(
            Object.entries(variable.valuesByMode)
              .sort(([a], [b]) => a.localeCompare(b))
              .map(([modeId, value]) => [modeId, normalizeValue(value)]),
          ),
        })),
    })),
};
