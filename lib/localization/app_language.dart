import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  const AppLanguage({
    required this.locale,
    required this.nativeName,
    required this.englishName,
  });

  final Locale locale;
  final String nativeName;
  final String englishName;

  static const supported = <AppLanguage>[
    AppLanguage(locale: Locale('en'), nativeName: 'English', englishName: 'English'),
    AppLanguage(locale: Locale('hi'), nativeName: 'हिन्दी', englishName: 'Hindi'),
    AppLanguage(locale: Locale('bn'), nativeName: 'বাংলা', englishName: 'Bengali'),
    AppLanguage(locale: Locale('gu'), nativeName: 'ગુજરાતી', englishName: 'Gujarati'),
    AppLanguage(locale: Locale('kn'), nativeName: 'ಕನ್ನಡ', englishName: 'Kannada'),
    AppLanguage(locale: Locale('mr'), nativeName: 'मराठी', englishName: 'Marathi'),
    AppLanguage(locale: Locale('ne'), nativeName: 'नेपाली', englishName: 'Nepali'),
    AppLanguage(locale: Locale('pa'), nativeName: 'ਪੰਜਾਬੀ', englishName: 'Punjabi'),
    AppLanguage(locale: Locale('ta'), nativeName: 'தமிழ்', englishName: 'Tamil'),
    AppLanguage(locale: Locale('te'), nativeName: 'తెలుగు', englishName: 'Telugu'),
  ];
}

class AppLanguageController {
  AppLanguageController._();

  static const _preferenceKey = 'vivah_app_language';
  static final ValueNotifier<Locale> locale = ValueNotifier(const Locale('en'));
  static final ValueNotifier<bool> hasSelectedLanguage = ValueNotifier(false);

  static Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final code = preferences.getString(_preferenceKey);
    if (code != null && AppLanguage.supported.any((language) => language.locale.languageCode == code)) {
      locale.value = Locale(code);
      hasSelectedLanguage.value = true;
    }
  }

  static Future<void> select(Locale selectedLocale) async {
    final supported = AppLanguage.supported.any(
      (language) => language.locale.languageCode == selectedLocale.languageCode,
    );
    if (!supported) return;
    locale.value = selectedLocale;
    hasSelectedLanguage.value = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, selectedLocale.languageCode);
  }
}
