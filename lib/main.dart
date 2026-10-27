import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/vivah_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VivahBioApp());
}

class VivahBioApp extends StatelessWidget {
  const VivahBioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivah Bio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: VivahColors.ivory,
        colorScheme: ColorScheme.fromSeed(
          seedColor: VivahColors.plum,
          primary: VivahColors.plum,
          surface: VivahColors.ivory,
        ),
        fontFamily: 'Roboto',
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
