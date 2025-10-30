## การจัดการ Font สำหรับ Localization หลายภาษา (Google Fonts: Noto Sans & Noto Sans Thai)

ในโปรเจกต์นี้ เราได้นำ Google Fonts มาใช้เพื่อจัดการ Font สำหรับการแสดงผลข้อความในภาษาต่างๆ โดยเฉพาะอย่างยิ่งการรองรับภาษาไทยด้วยฟอนต์ **Noto Sans Thai** เพื่อให้การแสดงผลเป็นไปอย่างถูกต้องและสวยงามตามหลักภาษาไทย

### 1. ทำไมต้องใช้ Noto Sans / Noto Sans Thai?

*   **รองรับหลายภาษา (Multilingual Support):** Noto (No Tofu) เป็นตระกูลฟอนต์ที่ Google พัฒนาขึ้นมาเพื่อรองรับภาษาและสคริปต์ต่างๆ ทั่วโลก ทำให้มั่นใจได้ว่าข้อความในภาษาใดๆ ก็ตามจะแสดงผลได้อย่างถูกต้อง ไม่เกิด "กล่องสี่เหลี่ยม" (Tofu) เมื่อไม่พบตัวอักษร
*   **ความสอดคล้อง (Consistency):** การใช้ Noto Sans เป็นฟอนต์หลักสำหรับภาษาทั่วไป และ Noto Sans Thai สำหรับภาษาไทยโดยเฉพาะ ช่วยให้แอปมีรูปลักษณ์ที่สอดคล้องกันทั่วทั้งแอป แม้จะเปลี่ยนภาษา
*   **การแสดงผลภาษาไทย:** Noto Sans Thai ถูกออกแบบมาเพื่อการแสดงผลภาษาไทยโดยเฉพาะ ทำให้สระ วรรณยุกต์ และพยัญชนะซ้อนกันได้อย่างถูกต้องตามหลักภาษาไทย

### 2. การติดตั้งและตั้งค่า `google_fonts`

เราใช้แพ็กเกจ `google_fonts` เพื่อให้สามารถเข้าถึงและใช้งานฟอนต์จาก Google Fonts ได้อย่างง่ายดาย

**`pubspec.yaml`:**
เพิ่ม `google_fonts` ในส่วน `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # ...
  google_fonts: ^6.1.0 # ตรวจสอบเวอร์ชันล่าสุดได้ที่ pub.dev
  # ...
```

หลังจากเพิ่มแล้ว ให้รัน `flutter pub get` เพื่อดาวน์โหลดแพ็กเกจ

### 3. การเลือก Font แบบ Dynamic ตาม Locale

หัวใจของการจัดการ Font สำหรับหลายภาษาในโปรเจกต์นี้คือการกำหนด `textTheme` ใน `MaterialApp` แบบ Dynamic โดยอิงตามภาษา (Locale) ที่ผู้ใช้เลือก

**`lib/main.dart`:**

ใน `MaterialApp` เราจะกำหนด `textTheme` ภายใน `theme` และ `darkTheme` โดยใช้เงื่อนไขเพื่อตรวจสอบ `languageCode` ของ `locale` ปัจจุบัน:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        // ตรวจสอบ Locale ปัจจุบันเพื่อเลือก TextTheme ที่เหมาะสม
        final currentLocale = localeProvider.locale;
        final TextTheme appTextTheme = currentLocale?.languageCode == 'th'
            ? GoogleFonts.notoSansThaiTextTheme() // สำหรับภาษาไทย
            : GoogleFonts.notoSansTextTheme();   // สำหรับภาษาอื่นๆ

        return MaterialApp(
          // ... การตั้งค่าอื่นๆ ...
          locale: localeProvider.locale, // Locale ที่ถูกเลือกโดยผู้ใช้
          theme: ThemeData.from(
            colorScheme: BaseTheme.lightColorScheme,
            useMaterial3: true,
          ).copyWith(
            textTheme: appTextTheme, // ใช้ TextTheme ที่เลือกไว้
            scaffoldBackgroundColor: ThemeColors.get('light', 'fill/base/300'),
          ),
          darkTheme: ThemeData.from(
            colorScheme: BaseTheme.darkColorScheme,
            useMaterial3: true,
          ).copyWith(
            textTheme: appTextTheme, // ใช้ TextTheme ที่เลือกไว้
            scaffoldBackgroundColor: ThemeColors.get('dark', 'fill/base/300'),
          ),
          themeMode: themeProvider.themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}
```

*   `GoogleFonts.notoSansThaiTextTheme()`: จะคืนค่า `TextTheme` ที่ใช้ฟอนต์ Noto Sans Thai สำหรับทุกสไตล์ข้อความ (headline, body, title ฯลฯ)
*   `GoogleFonts.notoSansTextTheme()`: จะคืนค่า `TextTheme` ที่ใช้ฟอนต์ Noto Sans สำหรับทุกสไตล์ข้อความ

### 4. การใช้งานใน Widget `Text`

หลังจากที่เรากำหนด `textTheme` ใน `MaterialApp` แล้ว Widget `Text` ต่างๆ ในแอป **ไม่ควร** กำหนด `style` โดยใช้ `GoogleFonts.fontName()` โดยตรงอีกต่อไป แต่ควรจะอ้างอิงจาก `Theme.of(context).textTheme` แทน เพื่อให้มันรับค่าฟอนต์ที่ถูกเลือกไว้แบบ Dynamic

**ตัวอย่างการใช้งานที่ถูกต้อง:**

```dart
// เดิม (ไม่แนะนำเมื่อมีการจัดการ font แบบ Dynamic)
Text(
  'ข้อความ',
  style: GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
);

// ใหม่ (แนะนำ)
Text(
  'ข้อความ',
  style: Theme.of(context).textTheme.bodyMedium?.copyWith( // เลือกสไตล์ที่เหมาะสม
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black, // สามารถกำหนดสีหรือคุณสมบัติอื่นๆ เพิ่มเติมได้
  ),
);
```

การใช้ `Theme.of(context).textTheme.bodyMedium?.copyWith()` ช่วยให้เราสามารถปรับแต่งคุณสมบัติอื่นๆ ของข้อความได้ (เช่น `fontSize`, `fontWeight`, `color`) โดยที่ยังคงใช้ฟอนต์หลักที่ถูกกำหนดไว้ใน `MaterialApp` ตาม Locale ปัจจุบัน

### 5. ประโยชน์ที่ได้รับ

*   **การจัดการ Font แบบรวมศูนย์:** การเปลี่ยนแปลงฟอนต์หลักของแอปสามารถทำได้จากจุดเดียวใน `main.dart`
*   **ความสอดคล้องของ UI:** มั่นใจได้ว่าฟอนต์ที่ใช้ทั่วทั้งแอปจะสอดคล้องกันตามภาษาที่เลือก
*   **ประสิทธิภาพ:** แพ็กเกจ `google_fonts` จัดการการดาวน์โหลดและแคชฟอนต์ให้โดยอัตโนมัติ
*   **รองรับภาษาไทยอย่างสมบูรณ์:** การใช้ Noto Sans Thai ช่วยให้การแสดงผลภาษาไทยเป็นไปอย่างถูกต้องและสวยงาม
