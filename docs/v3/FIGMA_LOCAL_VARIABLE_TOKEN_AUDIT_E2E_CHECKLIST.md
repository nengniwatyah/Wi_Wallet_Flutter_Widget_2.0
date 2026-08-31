# Portable E2E Checklist: Figma Local Variables → Theme Token Audit

คัมภีร์สำหรับนำระบบนี้ไปใช้กับ repository อื่น ตั้งแต่ดึง source ล่าสุด, สร้าง isolated worktree, อ่าน Local Variables จาก Figma, เก็บ snapshot รายวัน, compare กับ Flutter Theme V3 JSON, สร้าง Markdown report และตั้ง scheduled automation

> ระบบนี้เป็น audit-only: ห้ามแก้ Figma, token JSON, generated code, commit หรือ push โดยอัตโนมัติ

## 0. Configuration ที่ต้องกรอก

| ค่า | ตัวอย่าง | ค่าของ repo ใหม่ |
|---|---|---|
| Git remote | `https://github.com/org/repo.git` | |
| Baseline branch | `dev` | |
| Figma file key | `mhUvPg9tOjlvQvEW6glQhJ` | |
| Figma reference node | `596:1097` | |
| Primitive JSON directory | `lib/config/themes/v3/tokens/primitive/` | |
| Semantic JSON directory | `lib/config/themes/v3/tokens/semantic/` | |
| Snapshot directory | `docs/v3/figma-snapshots/<file-name>/` | |
| Report directory | `docs/v3/figma-token-audit/` | |
| Timezone | `Asia/Bangkok` | |
| Schedule | `Monday-Friday 11:00` | |

ห้ามเก็บ access token, OAuth code, cookie, query token หรือ secret ใน repo, snapshot, report หรือ automation prompt

## 0.1 Framework Adapter Configuration

ระบบแกนกลางต้องไม่ผูกกับ Flutter โดยตรง ให้ agent ตรวจ repo ก่อน แล้วกรอก adapter นี้เป็นไฟล์ configuration ของ repo ปลายทาง เช่น `.codex/figma-token-audit.json`:

```json
{
  "framework": "flutter",
  "language": "dart",
  "packageManager": "flutter",
  "baselineBranch": "dev",
  "primitiveTokenPaths": ["lib/config/themes/v3/tokens/primitive/"],
  "semanticTokenPaths": ["lib/config/themes/v3/tokens/semantic/"],
  "generatedPaths": ["lib/config/themes/v3/generated/"],
  "auditCommand": "npm run audit:figma-tokens",
  "buildOrTestCommand": "flutter analyze"
}
```

ห้ามนำ path, command, framework หรือ generated directory ของตัวอย่างนี้ไปใช้โดยไม่ตรวจ repo จริง

### Flutter adapter

```json
{
  "framework": "flutter",
  "language": "dart",
  "primitiveTokenPaths": ["lib/config/themes/v3/tokens/primitive/"],
  "semanticTokenPaths": ["lib/config/themes/v3/tokens/semantic/"],
  "generatedPaths": ["lib/config/themes/v3/generated/"],
  "auditCommand": "npm run audit:figma-tokens",
  "verificationCommands": ["flutter analyze", "flutter test"]
}
```

### React adapter

ตัวอย่างเมื่อ repo React ใช้ Style Dictionary หรือ DTCG JSON:

```json
{
  "framework": "react",
  "language": "typescript",
  "primitiveTokenPaths": ["tokens/primitive/"],
  "semanticTokenPaths": ["tokens/semantic/"],
  "generatedPaths": ["src/generated/tokens/", "src/styles/generated/"],
  "auditCommand": "npm run audit:figma-tokens",
  "verificationCommands": ["npm run lint", "npm test", "npm run build"]
}
```

React ที่ใช้ไฟล์ CSS, TypeScript หรือ package อื่นเป็น baseline ให้ระบุ directory/file จริงใน adapter โดย comparator ต้องยัง compare source token JSON ก่อน generated CSS/TypeScript เช่นเดียวกับ Flutter

### Framework-agnostic contract

ทุก adapter ต้องตอบคำถามเหล่านี้ให้ได้ก่อนเริ่ม:

```text
[ ] token source ที่มนุษย์แก้ไขอยู่ที่ไหน
[ ] primitive scope อยู่ที่ไหน
[ ] semantic scope อยู่ที่ไหน
[ ] alias/reference ถูกเขียนในรูปแบบใด
[ ] generated output อยู่ที่ไหน
[ ] คำสั่ง install, lint, test, build คืออะไร
[ ] baseline branch และ remote คืออะไร
[ ] framework มี light/dark หรือ mode mapping อย่างไร
```

สิ่งที่ต้องเหมือนกันทุก framework คือ snapshot schema, matching rules, drift categories, report Markdown, worktree isolation, security rules และ scheduled flow ส่วน path, parser, generator และ verification commands ต้องมาจาก adapter ของ repo นั้น

## 1. โครงสร้างไฟล์ขั้นต่ำ

```text
<repo>/
├── AGENTS.md
├── MEMORY.md
├── package.json
├── scripts/
│   ├── figma-local-variables-snapshot.code.js
│   └── figma-token-audit.mjs
└── docs/v3/
    ├── FIGMA_LOCAL_VARIABLE_TOKEN_AUDIT_E2E_CHECKLIST.md
    ├── figma-snapshots/<file-name>/YYYY-MM-DD.json
    └── figma-token-audit/YYYY-MM-DD.{json,md}
```

Flutter repo ต้องมี baseline JSON:

```text
lib/config/themes/v3/tokens/primitive/*.json
lib/config/themes/v3/tokens/semantic/*.json
```

ห้ามใช้ generated Dart แทน JSON เพราะ generated Dart เป็น derived output

## 2. Source-of-truth rules

- Figma Local Variables คือ source of truth ฝั่ง design
- `primitive/` และ `semantic/` คือ selected Flutter scope ไม่ใช่รายการที่ Figma ต้องมีครบทุกตัว
- Figma-only token เป็น inventory ไม่ใช่ error อัตโนมัติ
- Flutter token ที่หายจาก Figma, alias/mode/type/value ไม่ตรง คือ drift
- match ด้วย Figma variable ID ก่อน แล้ว fallback เป็น normalized name/path
- primitive compare raw value โดยตรง
- semantic compare alias/reference และ resolved value ของทุก mode
- ห้ามสรุปว่าไม่มี change จากชื่อหรือจำนวนที่เท่ากัน ต้องอ่าน Figma สดและ compare value จริง

## 3. Full Figma snapshot

`scripts/figma-local-variables-snapshot.code.js` ต้องเป็น read-only `figma-use` code ที่คืน JSON ด้วย top-level `return` และเก็บ:

```text
[ ] schemaVersion, provider, fileKey, referenceNodeId, capturedAt
[ ] ทุก Local Variable Collection รวม collection ว่าง
[ ] collection ID/name, hidden state, default mode
[ ] ทุก mode ID/name
[ ] variable ID/name, resolvedType, scopes, hidden state, codeSyntax
[ ] raw valuesByMode ครบทุก mode
[ ] alias target ID/name
[ ] resolved values แบบ recursive
[ ] alias cycle และ missing alias ถูกระบุ ไม่เดาค่า
[ ] collections/variables/modes/object keys sort แบบ deterministic
```

ถ้า output ใหญ่เกิน limit ให้ดึงเป็น chunk ตาม collection/variable IDs แล้วประกอบเป็นไฟล์เดียว ห้ามใช้ output ที่ถูกตัดทอน

บันทึกแบบ append-only:

```text
docs/v3/figma-snapshots/<file-name>/YYYY-MM-DD.json
```

ตรวจ snapshot ก่อนใช้:

```text
[ ] JSON parse ผ่าน
[ ] file key ถูกต้อง
[ ] collection และ variable count ครบ
[ ] collection ว่างไม่หาย
[ ] ทุก mode/value/alias/resolved value ครบ
[ ] ไม่มี credential
[ ] ไม่ overwrite snapshot เก่า
```

## 4. Comparator requirements

`scripts/figma-token-audit.mjs` ต้อง:

1. อ่าน snapshot และ JSON ทุกไฟล์ใต้ `primitive/` กับ `semantic/`
2. เดิน nested DTCG tokens ถึง leaf ที่มี `$type` และ `$value`
3. อ่าน `com.figma.variableId` และ alias metadata จาก `$extensions`
4. Resolve alias ใน JSON ก่อน compare
5. Normalize รูปแบบค่า:
   - Figma `{r,g,b,a}` กับ DTCG `components/alpha`
   - FLOAT กับ number/dimension
   - STRING กับ string alias ที่ resolve แล้ว
   - Figma alias กับ target resolved value
   - floating-point ด้วย tolerance ที่กำหนดตายตัว
6. เลือก mode ตามชื่อ `Light`, `Dark`, `Default` และ resolve target collection ที่มี mode ID ต่างกัน
7. ตรวจ type, raw value, alias, resolved value, mode และ mapping
8. แยกผลเป็น `matched`, `changed`, `missingInFigma`, `figmaOnly`
9. ใส่ layer, token path, mode และ JSON file ในทุก anomaly

Figma-only ห้ามถูกนับเป็น failure อัตโนมัติ

## 5. Markdown report contract

ต้องสร้างทั้ง:

```text
docs/v3/figma-token-audit/YYYY-MM-DD.json
docs/v3/figma-token-audit/YYYY-MM-DD.md
```

Markdown ต้องมี:

```markdown
# Figma Local Variables Token Audit
## สถานะ
## สรุป
| รายการ | จำนวน | ความหมาย |
## จุดที่ต้องตรวจแก้
| Layer | Token | Flutter file | Mode | ปัญหา | Flutter value | Figma value |
## Token ที่ไม่มีใน Figma
## Figma-only inventory
## คำแนะนำ
```

กฎ report:

- Changed ต้องมี before/after ครบทุก field/value ที่เปลี่ยน
- ต้องชี้ primitive/semantic, token path, mode และไฟล์ JSON
- Figma-only ต้องติดป้ายว่าเป็น inventory ที่ยังไม่เลือกใช้
- Figma access/fetch/snapshot failure ต้องเป็น blocker ไม่ใช่ PASS
- ไม่มี baseline ให้ระบุ `Initial snapshot`
- มี drift แล้วห้ามแก้ source อัตโนมัติ

## 6. Local command

เพิ่มใน `package.json`:

```json
{
  "scripts": {
    "audit:figma-tokens": "node scripts/figma-token-audit.mjs"
  }
}
```

รัน:

```bash
npm run audit:figma-tokens -- \
  --snapshot docs/v3/figma-snapshots/<file-name>/YYYY-MM-DD.json \
  --out docs/v3/figma-token-audit/YYYY-MM-DD.json
```

คำสั่งต้องสร้าง `.md` คู่กับ `.json` หรือรองรับ `--md-out <path>`

ตรวจ:

```bash
node --check scripts/figma-token-audit.mjs
git diff --check
```

Figma exporter เป็น top-level snippet ที่มี `return` จึงต้องตรวจผ่าน `figma-use` ไม่ใช่ `node --check`

## 7. E2E worktree workflow

ทุก scheduled run ต้องเริ่มจาก repo project checkout และไม่ใช้ checkout ที่ผู้ใช้กำลังทำงานอยู่:

```bash
git fetch origin dev
git rev-parse origin/dev
git worktree add --detach <fresh-worktree-path> origin/dev
```

ใน worktree ใหม่ต้องทำตามนี้:

```text
[ ] อ่าน AGENTS.md และ MEMORY.md
[ ] ตรวจ scripts และ token directories จาก exact origin/dev
[ ] ไม่ใช้ไฟล์จาก worktree อื่น
[ ] ดึง Figma สดและสร้าง snapshot ใหม่
[ ] ไม่ overwrite snapshot เก่า
[ ] รัน comparator
[ ] สร้าง JSON และ Markdown report
[ ] ตรวจ anomaly และ blocker
[ ] ห้ามแก้ Figma/token JSON/generated Dart
[ ] ห้าม commit/push อัตโนมัติ
[ ] เก็บ worktree ตามนโยบายเพื่อเปิดดูหลักฐานย้อนหลัง
```

ถ้า fetch, worktree, Figma, snapshot หรือ report ล้มเหลว ให้หยุดและรายงาน blocker ที่แน่นอน

## 8. Scheduled automation

ตั้ง local cron บน Git project ที่ถูกต้อง:

```text
ชื่อ: ตรวจ Token Figma (<repo>)
เวลา: Monday-Friday 11:00
Timezone: Asia/Bangkok หรือ timezone เครื่องที่ยืนยันแล้ว
สถานะ: ACTIVE
execution: local
project: <repo project id>
```

ใช้ prompt นี้เป็น template:

```text
ตรวจ Token Figma

Repository: <remote>
Baseline branch: dev
Figma file key: <file-key>
Figma reference node: <node-id>
Primitive JSON: <primitive-path>
Semantic JSON: <semantic-path>

ทุก run ต้อง fetch origin dev, ใช้ exact origin/dev ล่าสุด, สร้าง isolated
worktree ใหม่, อ่าน AGENTS.md/MEMORY.md, ดึง Local Variables ทั้งหมดจาก Figma
แบบ read-only, สร้าง dated full snapshot แบบ append-only, compare เฉพาะ
primitive/semantic JSON, และสร้าง JSON evidence กับ Markdown report

รายงานเป็นภาษาไทยแบบอ่านง่าย ต้องมี matched, changed, missing in Figma,
Figma-only และ before/after พร้อม token path, mode และไฟล์ที่เกี่ยวข้อง

ห้ามใช้ checkout อื่น, แก้ Figma, แก้ token JSON/generated code,
commit/push หรือสรุปว่าไม่มี drift หากข้อมูลไม่ครบ
```

ผู้ใช้ควรสั่งเพียง:

> ตรวจ Token Figma

Agent ต้องขยายคำสั่งสั้นนี้เป็น E2E flow ทั้งหมด ไม่ควรให้ผู้ใช้กรอก command ยาวทุกครั้ง

## 9. Acceptance checklist

### Source and safety

```text
[ ] project ID, remote และ baseline branch ถูกต้อง
[ ] Figma file key/node ถูกต้อง
[ ] ไม่มี secret ใน config/prompt/snapshot/report
[ ] configured checkout ไม่ถูกแก้ไข
```

### Snapshot

```text
[ ] ดึงจาก Figma สดจริง
[ ] collection/variable/mode count ครบ
[ ] collection ว่างไม่หาย
[ ] raw/alias/resolved values ครบ
[ ] JSON parse ผ่าน
[ ] snapshot เก่าไม่ถูก overwrite
```

### Comparison and report

```text
[ ] primitive และ semantic JSON ถูกอ่านครบ
[ ] ID mapping และ name/path fallback ทำงาน
[ ] color/number/string/alias normalization ผ่าน
[ ] Figma-only ไม่เป็น error อัตโนมัติ
[ ] changed/missing เป็น anomaly
[ ] มี JSON evidence และ Markdown report
[ ] Markdown มี summary, before/after, path, mode, file และคำแนะนำ
```

### Schedule

```text
[ ] ACTIVE จันทร์–ศุกร์ 11:00
[ ] ใช้ project ID ถูกต้อง
[ ] fetch origin/dev ก่อนทุกครั้ง
[ ] สร้าง fresh worktree ทุกครั้ง
[ ] ไม่มี automation ซ้ำ
[ ] manual run หรือรอบแรกทดสอบสำเร็จ
```

## 10. Definition of Done

ระบบพร้อมใช้งานเมื่อ scheduled run ใช้ exact `origin/<baseline-branch>` ใน fresh worktree, ได้ full Figma snapshot ที่เก็บย้อนหลัง, compare selected token scope ตาม framework adapter โดยไม่ false-positive จาก Figma-only, สร้าง Markdown ที่ชี้ anomaly พร้อม before/after ได้ทันที, รายงาน blocker เมื่อข้อมูลไม่ครบ และไม่แก้ external/source files โดยไม่ได้รับคำสั่ง

## 11. Portable handoff prompt สำหรับ repo อื่น

ให้ agent อ่านไฟล์นี้แล้วทำตาม prompt ต่อไปนี้:

```text
ติดตั้งระบบ Figma Local Variables Token Audit แบบ E2E ให้กับ repository นี้

เริ่มจากอ่าน AGENTS.md, MEMORY.md และตรวจ framework, package manager,
source token JSON, generated output, test/build commands, Git remote และ baseline branch
จาก repo จริงก่อน ห้ามเดาและห้ามใช้ path จากตัวอย่างโดยไม่ตรวจ

สร้าง Framework Adapter Configuration ของ repo นี้ แล้วทำระบบให้ครบ:
1. fetch origin/<baseline-branch> และสร้าง isolated worktree จาก exact remote ref
2. อ่าน Local Variables สดจาก Figma แบบ read-only
3. สร้าง full dated snapshot แบบ append-only
4. compare เฉพาะ primitive/semantic token paths ใน adapter
5. รองรับ variable ID, name/path fallback, mode, type, alias, raw/resolved value
6. แยก matched, changed, missing และ Figma-only โดยไม่ถือ Figma-only เป็น error อัตโนมัติ
7. สร้าง JSON evidence และ Markdown report ภาษาเข้าใจง่าย พร้อม before/after และไฟล์ที่ต้องแก้
8. ตั้ง scheduled automation จันทร์–ศุกร์ 11:00 ตาม timezone ที่ยืนยันได้

ห้ามแก้ Figma, source token JSON, generated output, commit หรือ push อัตโนมัติ
ถ้าข้อมูลหรือสิทธิ์ไม่ครบ ให้รายงาน blocker และหยุด ห้ามเดา
```
