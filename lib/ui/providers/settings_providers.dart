import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref){
  return ThemeNotifier();
});

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref){
  return FontSizeNotifier();
});

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en', ''));

  void changeLanguage(Locale locale) {
    state = locale;
  }
}

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void changeTheme(ThemeMode themeMode) {
    state = themeMode;
  }
}

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(16);

  void changeFontSize(double fontSize) {
    state = fontSize;
  }
}