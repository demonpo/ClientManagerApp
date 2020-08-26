import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';


class ISeeBtnIngreso extends Then1WithWorld<String, FlutterWorld> {
  ISeeBtnIngreso()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String value) async {
    await sleep(Duration(seconds: 5));

    final btn_ingresar = find.byValueKey("btn_ingresar");
    final btn_ingresar_by_text = find.text(value);
    expect(await FlutterDriverUtils.isPresent(world.driver, btn_ingresar), true);
    expect(await FlutterDriverUtils.isPresent(world.driver, btn_ingresar_by_text), true);
  }

  @override
  RegExp get pattern => RegExp(r"deberia ver el boton {string}");
}