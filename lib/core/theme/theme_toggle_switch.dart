import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickoyakovendors/core/theme/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Switch(
      value: themeController.isDarkMode,
      onChanged: (value) {
        themeController.toggleTheme();
      },
    );
  }
}
