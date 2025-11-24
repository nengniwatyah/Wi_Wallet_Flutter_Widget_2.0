// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mcp_test_app/widgetbook_use_cases.dart'
    as _mcp_test_app_widgetbook_use_cases;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'announce',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AnnouncementStack',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _mcp_test_app_widgetbook_use_cases.buildAnnouncementStack,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AnnouncementWarning',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _mcp_test_app_widgetbook_use_cases.buildAnnouncementWarning,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'item_list',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ItemList',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _mcp_test_app_widgetbook_use_cases.buildItemList,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'With Radio Button (Selected)',
                builder:
                    _mcp_test_app_widgetbook_use_cases.buildItemListSelected,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'With Trailing Text',
                builder:
                    _mcp_test_app_widgetbook_use_cases.buildItemListWithText,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
