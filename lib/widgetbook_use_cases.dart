import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:mcp_test_app/widgets/item_list/item_list.dart';
import 'package:mcp_test_app/widgets/announce/announcement.dart';
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';
import 'package:mcp_test_app/widgets/button/buttons.dart';
import 'package:mcp_test_app/widgets/card/card_review_transaction.dart';
import 'package:mcp_test_app/widgets/input/full_amount_input.dart';
import 'package:mcp_test_app/widgets/input/mobile_code_input.dart';
import 'package:mcp_test_app/widgets/input/search_input.dart';
import 'package:mcp_test_app/widgets/shortcut_menu/shortcut_menu.dart';
import 'package:mcp_test_app/widgets/visa/visa_card.dart';
import 'package:mcp_test_app/widgets/navigator_bar/navigator_bar.dart';
import 'package:mcp_test_app/widgets/drawer/drawer_balance_detail.dart';
import 'package:mcp_test_app/widgets/drawer/drawer_country_code.dart';
import 'package:mcp_test_app/widgets/drawer/drawer_deposit_channel.dart';
import 'package:mcp_test_app/widgets/drawer/drawer_review_transaction.dart';

// ItemList
@widgetbook.UseCase(name: 'Default', type: ItemList)
Widget buildItemList(BuildContext context) {
  return ItemList(title: 'Transaction History', onTap: () {});
}

@widgetbook.UseCase(name: 'With Trailing Text', type: ItemList)
Widget buildItemListWithText(BuildContext context) {
  return ItemList(title: 'Language', trailingText: 'English', onTap: () {});
}

@widgetbook.UseCase(name: 'With Radio Button (Selected)', type: ItemList)
Widget buildItemListSelected(BuildContext context) {
  return ItemList(title: 'English', isSelected: true, onTap: () {});
}

// Announcement
@widgetbook.UseCase(name: 'Default', type: AnnouncementStack)
Widget buildAnnouncementStack(BuildContext context) {
  return const AnnouncementStack();
}

@widgetbook.UseCase(name: 'Default', type: AnnouncementWarning)
Widget buildAnnouncementWarning(BuildContext context) {
  return const AnnouncementWarning(
    title: 'Warning',
    description: 'This is a warning message.',
  );
}

// Buttons
@widgetbook.UseCase(name: 'Primary', type: Buttons)
Widget buildButtonPrimary(BuildContext context) {
  return Buttons(
    text: 'Primary Button',
    type: ButtonType.primary,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Secondary', type: Buttons)
Widget buildButtonSecondary(BuildContext context) {
  return Buttons(
    text: 'Secondary Button',
    type: ButtonType.secondary,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Amount', type: Buttons)
Widget buildButtonAmount(BuildContext context) {
  return Buttons(text: '100', type: ButtonType.amount, onPressed: () {});
}

@widgetbook.UseCase(name: 'Disabled', type: Buttons)
Widget buildButtonDisabled(BuildContext context) {
  return const Buttons(text: 'Disabled Button', enabled: false);
}

// Card
@widgetbook.UseCase(name: 'Default', type: CardReviewTransaction)
Widget buildCardReviewTransaction(BuildContext context) {
  return const CardReviewTransaction(
    totalAmount: '100.00',
    fromLabel: 'From',
    fromValue: 'John Doe',
    mobileLabel: 'Mobile',
    mobileValue: '0812345678',
    toLabel: 'To',
    toValue: 'Jane Smith',
    accountNameLabel: 'Account Name',
    accountNameValue: 'Jane Smith',
    accountNumberLabel: 'Account Number',
    accountNumberValue: '123-4-56789-0',
  );
}

// Input
@widgetbook.UseCase(name: 'Default', type: FullAmountInput)
Widget buildFullAmountInput(BuildContext context) {
  return const FullAmountInput();
}

@widgetbook.UseCase(name: 'Default', type: MobileCodeInput)
Widget buildMobileCodeInput(BuildContext context) {
  return const MobileCodeInput();
}

@widgetbook.UseCase(name: 'Default', type: SearchInput)
Widget buildSearchInput(BuildContext context) {
  return const SearchInput();
}

// Shortcut Menu
@widgetbook.UseCase(name: 'Default', type: ShortcutMenuItem)
Widget buildShortcutMenu(BuildContext context) {
  return const ShortcutMenuItem(label: 'Transfer');
}

// Visa Card
@widgetbook.UseCase(name: 'Default', type: VisaCard)
Widget buildVisaCard(BuildContext context) {
  return const VisaCard();
}

// Navigator Bar
@widgetbook.UseCase(name: 'Default', type: NavigatorBar)
Widget buildNavigatorBar(BuildContext context) {
  return const NavigatorBar();
}

// Drawer
@widgetbook.UseCase(name: 'Balance Detail', type: DrawerBalanceDetail)
Widget buildDrawerBalanceDetail(BuildContext context) {
  return const DrawerBalanceDetail(
    totalBalanceLabel: 'Total Balance',
    totalBalanceAmount: '1,000.00',
    holdAmountLabel: 'Hold Amount',
    holdAmountValue: '100.00',
    ledgerBalanceLabel: 'Ledger Balance',
    ledgerBalanceValue: '900.00',
    warningText: '*Hold Amount is the amount that cannot be used.',
  );
}

@widgetbook.UseCase(name: 'Country Code', type: DrawerCountryCode)
Widget buildDrawerCountryCode(BuildContext context) {
  return const DrawerCountryCode(
    title: 'Select Country',
    countries: [
      CountryCode(
        name: 'Thailand',
        code: '+66',
        flagAsset: 'lib/assets/images/flag_th.svg',
      ),
      CountryCode(
        name: 'United States',
        code: '+1',
        flagAsset: 'lib/assets/images/flag_us.svg',
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Deposit Channel', type: DrawerDepositChannel)
Widget buildDrawerDepositChannel(BuildContext context) {
  return const DrawerDepositChannel();
}

@widgetbook.UseCase(name: 'Review Transaction', type: DrawerReviewTransaction)
Widget buildDrawerReviewTransaction(BuildContext context) {
  return const DrawerReviewTransaction(
    warningTitle: 'Warning',
    warningDescription: 'Please review your transaction.',
    totalAmount: '100.00',
    fromLabel: 'From',
    fromValue: 'John Doe',
    mobileLabel: 'Mobile',
    mobileValue: '0812345678',
    toLabel: 'To',
    toValue: 'Jane Smith',
    accountNameLabel: 'Account Name',
    accountNameValue: 'Jane Smith',
    accountNumberLabel: 'Account Number',
    accountNumberValue: '123-4-56789-0',
    objectLabel: 'Note',
    objectValue: 'Payment for services',
  );
}
