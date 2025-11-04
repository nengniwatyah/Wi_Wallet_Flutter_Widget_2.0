# Widgets Guide - Reusable Components

Complete guide to using all available widgets in this foundation.

## 📋 Table of Contents

- [NavigatorBar](#navigatorbar)
- [FullAmountInput](#fullamountinput)
- [MobileCodeInput](#mobilecodeinput)
- [SearchInput](#searchinput)
- [VisaCard](#visacard)
- [AnnouncementStack](#announcementstack)
- [AnnouncementWarning](#announcementwarning)
- [CardReviewTransaction](#cardreviewtransaction)
- [DrawerReviewTransaction](#drawerreviewtransaction)
- [ShortcutMenuItem](#shortcutmenuitem)
- [Buttons](#buttons)

---

## NavigatorBar

Bottom navigation bar with floating center button.

### Import

```dart
import 'package:your_app/widgets/navigator_bar/navigator_bar.dart';
```

### Usage

```dart
Scaffold(
  extendBody: true,
  bottomNavigationBar: NavigatorBar(
    opacity: 0.9, // Optional: 0.0 to 1.0
  ),
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| opacity | double | 0.9 | Background opacity (0.0-1.0) |

### Features

- 5 menu items: Home, Deposit, Scan, Convert, Setting
- Floating scan button in center
- Theme-aware colors
- Localized labels
- Responsive design

### Customization

To change icons, edit icon paths in `navigator_bar.dart`:

```dart
const String homeIcon = 'lib/assets/images/your-icon.svg';
```

---

## FullAmountInput

Amount input field with validation and clear button.

### Import

```dart
import 'package:your_app/widgets/full_amount_input.dart';
```

### Usage

```dart
final TextEditingController _amountController = TextEditingController();

FullAmountInput(
  controller: _amountController,
  initialValue: '100.00',
  onChanged: (value) {
    print('Amount: $value');
  },
  infoText: 'ท่านต้องฝากเงินอย่างน้อย 100 THB',
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| controller | TextEditingController? | null | Text controller |
| initialValue | String? | null | Initial value |
| onChanged | ValueChanged<String>? | null | Callback on text change |
| infoText | String | 'ท่านต้องฝากเงินอย่างน้อย 100 THB' | Info/error message |

### Features

- Decimal number input
- Minimum validation (100)
- Auto-format with ฿ symbol
- Clear button (X) when has text
- Error state (red) when < 100
- Success state (green) when >= 100
- Focus state with primary color border

### States

```dart
// Normal state - gray border
// Focus state - primary color border
// Error state - red border (value < 100)
// Success state - green text (value >= 100)
```

### Example with Validation

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _controller = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullAmountInput(
          controller: _controller,
          onChanged: (value) {
            setState(() {
              _isValid = (double.tryParse(value) ?? 0) >= 100;
            });
          },
        ),
        ElevatedButton(
          onPressed: _isValid ? _submit : null,
          child: Text('Submit'),
        ),
      ],
    );
  }

  void _submit() {
    print('Amount: ${_controller.text}');
  }
}
```

---

## MobileCodeInput

Country code selector with phone number input.

### Import

```dart
import 'package:your_app/widgets/mobile_code_input.dart';
```

### Usage

```dart
MobileCodeInput(
  onChanged: (countryCode, phoneNumber) {
    print('Code: $countryCode, Number: $phoneNumber');
  },
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| onChanged | Function(String, String)? | null | Callback with code and number |

### Features

- Country code dropdown
- Phone number input
- Auto-formatting
- Validation
- Theme-aware

### Supported Countries

- 🇹🇭 Thailand (+66)
- 🇺🇸 USA (+1)
- 🇬🇧 UK (+44)
- 🇨🇳 China (+86)
- 🇯🇵 Japan (+81)

---

## SearchInput

Search input field with icon.

### Import

```dart
import 'package:your_app/widgets/search_input.dart';
```

### Usage

```dart
final TextEditingController _searchController = TextEditingController();

SearchInput(
  controller: _searchController,
  hintText: 'Search...',
  onChanged: (value) {
    // Perform search
    searchItems(value);
  },
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| controller | TextEditingController? | null | Text controller |
| hintText | String | 'Search...' | Placeholder text |
| onChanged | ValueChanged<String>? | null | Callback on text change |

### Features

- Search icon
- Clear button
- Debounced search (optional)
- Theme-aware

---

## VisaCard

Gradient visa card display.

### Import

```dart
import 'package:your_app/widgets/visa/visa_card.dart';
```

### Usage

```dart
VisaCard(
  cardNumber: '1234 5678 9012 3456',
  expiryDate: '12/25',
  balance: 50000.00,
  cardholderName: 'JOHN DOE', // Optional
)
```

### Properties

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| cardNumber | String | Yes | Card number (16 digits) |
| expiryDate | String | Yes | Expiry date (MM/YY) |
| balance | double | Yes | Card balance |
| cardholderName | String? | No | Cardholder name |

### Features

- Gradient background
- Visa logo
- Formatted card number
- Balance display
- Responsive design

### Example

```dart
ListView(
  children: [
    VisaCard(
      cardNumber: '4532 1234 5678 9010',
      expiryDate: '12/25',
      balance: 25000.50,
    ),
    SizedBox(height: 16),
    VisaCard(
      cardNumber: '5425 2334 3010 9903',
      expiryDate: '06/26',
      balance: 15000.00,
    ),
  ],
)
```

---

## AnnouncementStack

Animated announcement cards with auto-rotation.

### Import

```dart
import 'package:your_app/widgets/announce/announcement.dart';
```

### Usage

```dart
AnnouncementStack(
  messages: [
    'Welcome to our app!',
    'New features available',
    'Check out our latest updates',
  ],
  autoRotate: true,
  rotationDuration: Duration(seconds: 5),
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| messages | List<String> | required | List of messages |
| autoRotate | bool | true | Auto-rotate messages |
| rotationDuration | Duration | 5s | Time between rotations |

### Features

- Stack card layout
- Slide out animation
- Auto-rotation
- Dismissible cards
- Theme-aware

### Example with Custom Messages

```dart
class HomePage extends StatelessWidget {
  final List<String> announcements = [
    'System maintenance on Sunday',
    'New payment method available',
    'Refer a friend and get rewards',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnnouncementStack(
            messages: announcements,
            autoRotate: true,
          ),
          // Other widgets...
        ],
      ),
    );
  }
}
```

---

## AnnouncementWarning

Static warning alert component.

### Import

```dart
import 'package:your_app/widgets/announce/announcement_warning.dart';
```

### Usage

```dart
AnnouncementWarning(
  title: 'Please recheck information before proceeding',
  description: 'To prevent wrong account transfers or fraudulent activities.',
)
```

### Properties

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| title | String | Yes | Warning title |
| description | String | Yes | Warning description |

### Features

- Fixed warning colors
- Alert icon (24x24px)
- Multi-line text support
- No animation (static)
- Thai font support

---

## CardReviewTransaction

Transaction review card component.

### Import

```dart
import 'package:your_app/widgets/card_review_transaction.dart';
```

### Usage

```dart
CardReviewTransaction(
  totalAmount: '5,000.00',
  feeAmount: '0.00',
  currency: 'THB',
  fromLabel: 'From',
  fromValue: 'Your Wi Wallet',
  mobileLabel: 'Mobile Number',
  mobileValue: '081-141-1234',
  toLabel: 'To',
  toValue: 'Siam Commercial Bank',
  accountNameLabel: 'Account Name',
  accountNameValue: 'Victor Von Doom',
  accountNumberLabel: 'Account Number',
  accountNumberValue: '1234567890',
)
```

### Features

- Total amount display (green)
- Fee information
- Transaction details (from/to)
- Account information
- Theme-aware
- Responsive design

---

## DrawerReviewTransaction

Bottom sheet drawer for transaction review.

### Import

```dart
import 'package:your_app/widgets/drawer_review_transaction.dart';
```

### Usage

```dart
DrawerReviewTransaction.show(
  context,
  warningTitle: 'Please recheck information before proceeding',
  warningDescription: 'To prevent wrong account transfers.',
  totalAmount: '5,000.00',
  feeAmount: '0.00',
  currency: 'THB',
  fromLabel: 'From',
  fromValue: 'Your Wi Wallet',
  mobileLabel: 'Mobile Number',
  mobileValue: '081-141-1234',
  toLabel: 'To',
  toValue: 'Siam Commercial Bank',
  accountNameLabel: 'Account Name',
  accountNameValue: 'Victor Von Doom',
  accountNumberLabel: 'Account Number',
  accountNumberValue: '1234567890',
  objectLabel: 'Object',
  objectValue: 'Personal expenses',
  confirmButtonText: 'Confirm',
  onConfirm: () {
    Navigator.pop(context);
    print('Transaction confirmed');
  },
);
```

### Properties

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| warningTitle | String | Yes | - | Warning title |
| warningDescription | String | Yes | - | Warning description |
| totalAmount | String | Yes | - | Total amount |
| feeAmount | String | No | '0.00' | Fee amount |
| currency | String | No | 'THB' | Currency code |
| objectLabel | String | Yes | - | Object label |
| objectValue | String | Yes | - | Object value |
| confirmButtonText | String | No | 'Confirm' | Button text |
| onConfirm | VoidCallback? | No | null | Confirm callback |

### Features

- Modal bottom sheet (75% height)
- Scrollable content
- Warning message
- Transaction details
- Object information
- Confirm button
- Close button
- Swipe to dismiss
- Theme-aware

### Behavior

- Shows from bottom of screen
- Fixed height (75% of screen)
- Content scrollable
- Backdrop overlay
- Rounded top corners

---

## ShortcutMenuItem

Menu item with icon and label.

### Import

```dart
import 'package:your_app/widgets/shortcut_menu.dart';
```

### Usage

```dart
ShortcutMenuItem(
  icon: 'lib/assets/images/transfer-icon.svg',
  label: 'Transfer',
  onTap: () {
    // Handle tap
    Navigator.push(context, ...);
  },
)
```

### Properties

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| icon | String | Yes | SVG icon path |
| label | String | Yes | Menu label |
| onTap | VoidCallback? | No | Tap callback |

### Example - Menu Grid

```dart
GridView.count(
  crossAxisCount: 3,
  children: [
    ShortcutMenuItem(
      icon: 'lib/assets/images/transfer.svg',
      label: AppLocalizations.of(context)!.transfer,
      onTap: () => Navigator.pushNamed(context, '/transfer'),
    ),
    ShortcutMenuItem(
      icon: 'lib/assets/images/topup.svg',
      label: AppLocalizations.of(context)!.top_up,
      onTap: () => Navigator.pushNamed(context, '/topup'),
    ),
    ShortcutMenuItem(
      icon: 'lib/assets/images/bill.svg',
      label: AppLocalizations.of(context)!.bill,
      onTap: () => Navigator.pushNamed(context, '/bill'),
    ),
  ],
)
```

---

## Buttons

Collection of themed buttons.

### Import

```dart
import 'package:your_app/widgets/buttons.dart';
```

### Primary Button

```dart
PrimaryButton(
  text: 'Submit',
  onPressed: () {
    // Handle press
  },
  isLoading: false,
)
```

### Secondary Button

```dart
SecondaryButton(
  text: 'Cancel',
  onPressed: () {
    // Handle press
  },
)
```

### Outlined Button

```dart
OutlinedButton(
  text: 'Learn More',
  onPressed: () {
    // Handle press
  },
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| text | String | required | Button text |
| onPressed | VoidCallback? | null | Press callback |
| isLoading | bool | false | Show loading indicator |
| width | double? | null | Button width |
| height | double | 48 | Button height |

---

## 🎨 Theme Integration

All widgets automatically adapt to:
- Light/Dark mode
- Current locale
- Design tokens

### Example - Theme-Aware Widget

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light 
      ? 'light' 
      : 'dark';
    
    return Container(
      color: ThemeColors.get(brightnessKey, 'fill/base/100'),
      child: Text(
        'Hello',
        style: TextStyle(
          color: ThemeColors.get(brightnessKey, 'text/base/600'),
        ),
      ),
    );
  }
}
```

---

## 🧪 Testing Widgets

### Widget Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/widgets/full_amount_input.dart';

void main() {
  testWidgets('FullAmountInput shows error for invalid amount', (tester) async {
    final controller = TextEditingController();
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FullAmountInput(controller: controller),
        ),
      ),
    );

    // Enter invalid amount
    await tester.enterText(find.byType(TextField), '50');
    await tester.pump();

    // Verify error state
    expect(controller.text, '50');
  });
}
```

---

## 📝 Creating Custom Widgets

### Template

```dart
import 'package:flutter/material.dart';
import 'package:your_app/config/themes/theme_color.dart';

class MyCustomWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  
  const MyCustomWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light 
      ? 'light' 
      : 'dark';
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeColors.get(brightnessKey, 'fill/base/100'),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ThemeColors.get(brightnessKey, 'stroke/base/100'),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: ThemeColors.get(brightnessKey, 'text/base/600'),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
```

---

## 💡 Best Practices

1. **Always use ThemeColors** - Never hardcode colors
2. **Support both themes** - Test light and dark mode
3. **Use const constructors** - Better performance
4. **Add null safety** - Use ? and required
5. **Provide callbacks** - Make widgets flexible
6. **Document properties** - Help other developers
7. **Create preview widgets** - Easy testing

---

## 🆘 Need Help?

- 📖 Check [README.md](README.md)
- 🔧 See [SETUP_GUIDE.md](SETUP_GUIDE.md)
- 💬 Open [Discussion](https://github.com/yourusername/flutter_test_app/discussions)

---

Happy coding! 🚀
