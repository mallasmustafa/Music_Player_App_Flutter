import 'package:flutter/material.dart';
import 'package:music_player_app/theme/dark_theme.dart';
import 'package:music_player_app/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => themeData == darkTheme;
  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toogleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
