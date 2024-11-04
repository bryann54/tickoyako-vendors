import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Make sure to add provider to your pubspec.yaml
import 'package:tickoyakovendors/core/theme/app_theme.dart'; // Assuming your AppTheme is in core/theme/app_theme.dart
import 'package:tickoyakovendors/core/theme/theme_controller.dart';
import 'package:tickoyakovendors/features/auth/presentation/pages/splash_screen.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(), // Initialize ThemeController
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TickoYako Vendors',
            theme: AppTheme.lightTheme, // Light theme
            darkTheme: AppTheme.darkTheme, // Dark theme
            themeMode: themeController.themeMode, // Set the theme mode
            home: const SplashScreen(), // Your app's home screen
          );
        },
      ),
    );
  }
}
