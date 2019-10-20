import 'package:bloc_pattern_mark1/src/di/bloc-injector.dart';
import 'package:bloc_pattern_mark1/src/di/bloc-module.dart';
import 'package:flutter/material.dart';

void main() async {
  var container = await BlocInjector.create(BlocModule());
  runApp(container.app);
}
