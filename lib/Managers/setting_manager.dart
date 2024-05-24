import 'package:flutter/material.dart';

class SettingsManager extends ChangeNotifier {

  bool _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}