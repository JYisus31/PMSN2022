import 'package:flutter/material.dart';

ThemeData temaDia() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(primaryColor: Colors.blueGrey);
}

ThemeData temaNoche() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(primaryColor: Color.fromARGB(210, 11, 20, 119));
}

ThemeData temaCalido() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(primaryColor: Color.fromARGB(221, 90, 7, 233));
}
