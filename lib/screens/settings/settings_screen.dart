import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  bool isDarkMode;
  Function toggleDarkMode;
  SettingsScreen(this.isDarkMode, this.toggleDarkMode);

  static String routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: SwitchListTile(
          value: isDarkMode,
          onChanged: (value) => toggleDarkMode(),
          title: Text("Enable Dark Mode"),
        ),
      ),
    );
  }
}
