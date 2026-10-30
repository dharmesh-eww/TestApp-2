import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_language.dart';
import 'screens/splash_screen.dart';
import 'screens/vivah_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLanguageController.load();
  runApp(const VivahBioApp());
}

class VivahBioApp extends StatelessWidget {
  const VivahBioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLanguageController.locale,
      builder: (context, locale, _) => MaterialApp(
        title: 'Vivah Bio',
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: AppLanguage.supported.map((language) => language.locale),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
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
      ),
    );
  }
}
