import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

import 'package:seatly/ui/providers/settings_providers.dart';
import 'package:seatly/ui/widget/settings/font_item.dart';
import 'package:seatly/ui/widget/settings/language_item.dart';
import 'package:seatly/ui/widget/settings/theme_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final language = ref.watch(languageProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.generalSettings,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LanguageItem(
                    title: AppLocalizations.of(context)!.languages,
                    bgColor: Colors.orange.shade100,
                    iconColor: Colors.orange,
                    icon: Ionicons.globe_outline,
                    value: language.languageCode,
                    onChanged: (String? newLanguage) {
                      if (newLanguage != null) {
                        ref.read(languageProvider.notifier).changeLanguage(Locale(newLanguage));
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ThemeSwitch(
                    title: AppLocalizations.of(context)!.theme,
                    bgColor: Colors.purple.shade100,
                    iconColor: Colors.purple,
                    icon: Ionicons.partly_sunny_outline,
                    value: themeMode == ThemeMode.dark,
                    onTap: (bool value) {
                      ref.read(themeProvider.notifier).changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                  const SizedBox(height: 20),
                  FontItem(
                    title: AppLocalizations.of(context)!.font,
                    bgColor: Colors.blue.shade100,
                    iconColor: Colors.blue,
                    icon: Ionicons.text_outline,
                    value: fontSize,
                    onChanged: (double? newSize) {
                      if (newSize != null) {
                        ref.read(fontSizeProvider.notifier).changeFontSize(newSize);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.feedback,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}