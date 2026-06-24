import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  final replacements = {
    'Color(0xFF1A2340)': 'AppTheme.cardColor',
    'Color(0xFF2844B4)': 'AppTheme.primaryLighter',
    'Color(0xFF0A123D)': 'AppTheme.primaryDarker',
    'Color(0xFF8E99AF)': 'AppTheme.mutedTextColor',
    'Color(0xFFFFC107)': 'AppTheme.warningColor',
    'Color(0xFF3B68E7)': 'AppTheme.accentBlue',
    'const Color(0xFF1A2340)': 'AppTheme.cardColor',
    'const Color(0xFF2844B4)': 'AppTheme.primaryLighter',
    'const Color(0xFF0A123D)': 'AppTheme.primaryDarker',
    'const Color(0xFF8E99AF)': 'AppTheme.mutedTextColor',
    'const Color(0xFFFFC107)': 'AppTheme.warningColor',
    'const Color(0xFF3B68E7)': 'AppTheme.accentBlue',
  };

  int changedFiles = 0;

  for (final file in files) {
    String content = file.readAsStringSync();
    bool changed = false;

    // First try replacing with const modifier intact if it doesn't break things, but AppTheme.xyz is already const
    // Actually replacing `const Color(...)` with `AppTheme...` is safer so we don't end up with `const AppTheme.cardColor` which might be fine but sometimes throws if not expected. Wait, AppTheme vars are static const, so `const AppTheme.cardColor` is actually invalid in Dart. It must be just `AppTheme.cardColor`.

    for (final entry in replacements.entries) {
      if (content.contains(entry.key)) {
        content = content.replaceAll(entry.key, entry.value);
        changed = true;
      }
    }

    // After replacing colors, we need to ensure app_theme is imported
    if (changed && !content.contains('app_theme.dart')) {
      // Find the last import
      final importRegex = RegExp('import\\s+[\'"].*?[\'"];\\n');
      final matches = importRegex.allMatches(content);
      if (matches.isNotEmpty) {
        final lastMatch = matches.last;
        content = content.replaceRange(lastMatch.end, lastMatch.end, "import 'package:handy/config/themes/app_theme.dart';\n");
      }
    }

    if (changed) {
      file.writeAsStringSync(content);
      changedFiles++;
    }
  }

  stdout.writeln('Successfully updated $changedFiles files.');
}
