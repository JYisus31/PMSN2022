import 'package:flutter/material.dart';
import 'package:practica1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/theme_provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    late SharedPreferences _prefs;
    return Scaffold(
      body: Center(
        child: Column(children: [
          TextButton.icon(
              onPressed: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.setString("tema", "dia");
                tema.setthemeData(temaDia());
              },
              icon: Icon(Icons.brightness_high),
              label: Text("Tema Día")),
          TextButton.icon(
              onPressed: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.setString("tema", "noche");
                tema.setthemeData(temaNoche());
              },
              icon: Icon(Icons.dark_mode_sharp),
              label: Text("Tema Noche")),
          TextButton.icon(
              onPressed: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.setString("tema", "calido");
                tema.setthemeData(temaCalido());
              },
              icon: Icon(Icons.thermostat_rounded),
              label: Text("Tema calido")),
        ]),
      ),
    );
  }
}
