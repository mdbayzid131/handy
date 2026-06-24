import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  int changedFiles = 0;

  for (final file in files) {
    String content = file.readAsStringSync();
    bool changed = false;

    if (content.contains('const AppTheme.')) {
      content = content.replaceAll('const AppTheme.', 'AppTheme.');
      changed = true;
    }

    if (content.contains('AppTheme.') && !content.contains('app_theme.dart')) {
      final importRegex = RegExp('import\\s+[\'"].*?[\'"];\\r?\\n');
      final matches = importRegex.allMatches(content);
      if (matches.isNotEmpty) {
        final lastMatch = matches.last;
        content = content.replaceRange(lastMatch.end, lastMatch.end, "import 'package:handy/config/themes/app_theme.dart';\r\n");
        changed = true;
      }
    }

    if (changed) {
      file.writeAsStringSync(content);
      changedFiles++;
    }
  }

  stdout.writeln('Successfully fixed $changedFiles files.');
}
