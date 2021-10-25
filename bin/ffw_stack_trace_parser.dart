import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:console/console.dart';
import 'package:source_map_stack_trace/source_map_stack_trace.dart';
import 'package:source_maps/parser.dart';
import 'package:stack_trace/stack_trace.dart';

const String kSourceMapToken = 'source-map';
const String kInputToken = 'input';
const String kOutputToken = 'output';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser();
  parser.addOption(
    kSourceMapToken,
    mandatory: true,
    help:
        'The path source map output from command "flutter build web --source-maps".',
  );
  parser.addOption(
    kInputToken,
    abbr: 'i',
    help: 'The path to the error message file.',
    mandatory: true,
  );
  parser.addOption(
    kOutputToken,
    abbr: 'o',
    help: 'The path to output the de-obfuscated error message.',
  );

  try {
    final parsedResults = parser.parse(arguments);
    final inputFile = File(parsedResults[kInputToken]);
    final sourceMapFile = File(parsedResults[kSourceMapToken]);

    final sourceMap = await sourceMapFile.readAsString();
    final input = await inputFile.readAsString();
    final originalStackTrace = Trace.parseJSCore(input);
    final dartTrace = mapStackTrace(
      parseJson(jsonDecode(sourceMap)),
      originalStackTrace,
      minified: true,
    );

    if (parsedResults.wasParsed(kOutputToken)) {
      final outputFile = File(parsedResults[kOutputToken]);
      await outputFile.create(recursive: true);
      await outputFile.writeAsString(dartTrace.toString());
      print('Done writing de-obfuscated stack trace to: ${outputFile.path}');
    } else {
      print(dartTrace);
    }
  } catch (ex) {
    handleException(ex, parser);
  }
}

void handleException(dynamic ex, ArgParser parser) {
  final textPen = TextPen();
  textPen.red();
  if (ex is String) {
    textPen.text('$ex\n');
  } else if (ex is FormatException) {
    textPen.text('${ex.message}\n');
  } else {
    print(ex);
  }

  textPen.white();

  textPen.text('\n');
  textPen.text('${parser.usage}\n');
  textPen.print();
}
