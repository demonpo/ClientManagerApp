import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/estado_inicial.dart';

Future<void> main() {
final config = FlutterTestConfiguration()
..features = [Glob(r"test_driver/features/**.feature")]
..reporters = [ProgressReporter()]
..stepDefinitions = [ISeeBtnIngreso()]
..restartAppBetweenScenarios = true
..targetAppPath = "test_driver/app.dart"
..exitAfterTestRun = false;
return GherkinRunner().execute(config);
}