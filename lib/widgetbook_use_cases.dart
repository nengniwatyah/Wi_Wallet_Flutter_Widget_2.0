import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:mcp_test_app/widgets/item_list/item_list.dart';
import 'package:mcp_test_app/widgets/announce/announcement.dart';
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';

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
