import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings with ChangeNotifier {
  bool isDarkMode = false;

  //Toggle Dark Mode Theme
  Future<void> toggleDarkMode() async {
    isDarkMode = !isDarkMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("DarkMode", isDarkMode);
    notifyListeners();
  }

  //Fetch Dark Mode from the device
  Future<void> fetchDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("DarkMode")) {
      return false;
    }
    isDarkMode = prefs.getBool("DarkMode");
    notifyListeners();
  }
}
