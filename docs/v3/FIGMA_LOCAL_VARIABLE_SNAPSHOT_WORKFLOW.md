# Figma Local Variables Snapshot Workflow

สำหรับการติดตั้งระบบนี้ใน repo อื่นแบบ E2E ให้ใช้ [FIGMA_LOCAL_VARIABLE_TOKEN_AUDIT_E2E_CHECKLIST.md](FIGMA_LOCAL_VARIABLE_TOKEN_AUDIT_E2E_CHECKLIST.md)

แหล่งข้อมูลต้นทางคือไฟล์ `Wi Design System` (`mhUvPg9tOjlvQvEW6glQhJ`, reference node `596:1097`) และ JSON ที่เลือกใช้ใน Flutter คือ `lib/config/themes/v3/tokens/primitive/` กับ `lib/config/themes/v3/tokens/semantic/` เท่านั้น

## สร้าง snapshot

ใช้เนื้อหาใน `scripts/figma-local-variables-snapshot.code.js` ผ่าน `figma-use` แบบ read-only แล้วบันทึกผลลัพธ์เป็นไฟล์ใหม่ ห้ามเขียนทับ snapshot เดิม:

```text
docs/v3/figma-snapshots/Wi-Design-System/YYYY-MM-DD.json
```

Snapshot ต้องเก็บ Local Variable ทั้งหมดของ Figma แม้ token นั้นยังไม่ได้เลือกมาใช้ใน Flutter เพื่อให้เห็น additions/removals ในฝั่ง design อย่างครบถ้วน

## Compare กับ Flutter

ครั้งถัดไปให้สั่งสั้นๆ ว่า:

> ตรวจ Token Figma

ระบบจะสร้าง snapshot วันนี้, compare กับ Flutter Theme V3 และสร้าง report Markdown ที่อ่านง่ายพร้อม JSON evidence

```bash
node scripts/figma-token-audit.mjs \
  --config .codex/figma-token-audit.json \
  --snapshot docs/v3/figma-snapshots/Wi-Design-System/YYYY-MM-DD.json \
  --out docs/v3/figma-token-audit/YYYY-MM-DD.json
```

คำสั่งนี้สร้าง Markdown คู่กันที่ `docs/v3/figma-token-audit/YYYY-MM-DD.md` โดยอัตโนมัติ หรือกำหนดเองด้วย `--md-out <path>`

รายงาน Markdown จะแยก `matched`, `changed`, `missingInFigma` และ `figmaOnly` พร้อมตาราง before/after, path ของ token, ไฟล์ JSON และ mode ที่ผิดปกติ โดย `figmaOnly` เป็นข้อมูล inventory ไม่ใช่ error อัตโนมัติ ส่วน `changed` และ `missingInFigma` คือ drift ที่ต้อง review

ก่อนสร้างโฟลเดอร์ snapshot จริง ให้ตรวจสิทธิ์และนโยบายการ commit ของทีมก่อน เพราะ snapshot อาจมีข้อมูลจำนวนมากและมี Figma variable IDs; ห้ามบันทึก access token, query token หรือ credential ใดๆ ลงใน snapshot
