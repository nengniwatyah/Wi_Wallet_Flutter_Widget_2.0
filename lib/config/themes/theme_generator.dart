import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';

void main() async {
  // Configure logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.level >= Level.INFO) {
      stderr.writeln('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  final logger = Logger('ThemeGenerator');

  // Read theme.json
  final themeJson = await File('lib/config/themes/theme.json').readAsString();
  final themeData = json.decode(themeJson) as List<dynamic>;

  // Extract color theme data
  final colorTheme = themeData.firstWhere((t) => t['name'] == 'Color Theme');
  final modes = colorTheme['values'] as List<dynamic>;

  // Prepare output
  final buffer = StringBuffer();
  buffer.write("import 'package:flutter/material.dart';\n\n");
  buffer.write("class ThemeColors {\n");

  // Process each mode (Light and Dark)
  for (final mode in modes) {
    final modeName = mode['mode']['name'].toLowerCase();
    buffer.write("  static final Map<String, Color> $modeName = {\n");

    // Process colors
    final colors = mode['color'] as List<dynamic>;
    for (final color in colors) {
      final name = color['name'] as String;
      final value = color['value'] as String;

      buffer.write("    '$name': _hex('$value'),\n");
    }

    buffer.write("  };\n\n");
  }

  // Add get helper method
  buffer.write("\n");
  buffer.write("  static Color get(String theme, String key) {\n");
  buffer.write("    if (theme == 'light') {\n");
  buffer.write("      return light[key] ?? dark[key] ?? Colors.transparent;\n");
  buffer.write("    } else {\n");
  buffer.write("      return dark[key] ?? light[key] ?? Colors.transparent;\n");
  buffer.write("    }\n");
  buffer.write("  }\n");

  // Add _hex helper method
  buffer.write("\n");
  buffer.write("  static Color _hex(String hex) {\n");
  buffer.write("    hex = hex.replaceAll('#', '');\n");
  buffer.write("    if (hex.length == 6) {\n");
  buffer.write("      hex = 'FF\$hex';\n");
  buffer.write("    } else if (hex.length == 8) {\n");
  buffer.write("      hex = '\${hex.substring(6)}\${hex.substring(0, 6)}';\n");
  buffer.write("    }\n");
  buffer.write("    return Color(int.parse(hex, radix: 16));\n");
  buffer.write("  }\n");
  buffer.write("}");

  // Write to file
  await File(
    'lib/config/themes/theme_color.dart',
  ).writeAsString(buffer.toString());

  logger.info('ThemeColors has been successfully generated from theme.json');
}
