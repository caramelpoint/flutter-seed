import 'dart:io';
import 'package:flutter/material.dart';
import 'package:git_hooks/git_hooks.dart';

void main(List<String> arguments) {
  final Map<Git, UserBackFun> params = <Git, UserBackFun>{Git.preCommit: preCommit};
  change(arguments, params);
}

Future<bool> preCommit() async {
  try {
    final ProcessResult analyzeResult = await Process.run('flutter', <String>['analyze']);
    if (analyzeResult.stdout.toString().contains('No issues found!')) {
      debugPrint('No issues found!');
      final ProcessResult testResult = await Process.run('flutter', <String>['test']);
      if (testResult.stdout.toString().contains('All tests passed!')) {
        debugPrint('All tests passed!!');
        return true;
      } else {
        debugPrint('Unit Tests Failed, please fix it before commit!');
        debugPrint(testResult.stdout.toString());
        return false;
      }
    } else {
      debugPrint('Flutter Analyze Failed, please fix it before commit!');
      debugPrint(analyzeResult.stdout.toString());
      return false;
    }
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
