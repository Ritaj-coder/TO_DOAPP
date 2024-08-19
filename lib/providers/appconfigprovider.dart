import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  //data
  String applanguage = "en";

  ThemeMode apptheme = ThemeMode.light;

  void changelanguage(String newlanguage) {
    if (applanguage == newlanguage) {
      return;
    }
    applanguage = newlanguage;
    notifyListeners();
  }

  void changemode(ThemeMode newmode) {
    if (apptheme == newmode) {
      return;
    }
    apptheme = newmode;
    notifyListeners();
  }
}
