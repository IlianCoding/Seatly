import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final String value;
  final Function(String?) onChanged;

  const LanguageItem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'icon': CountryFlag.fromLanguageCode('en', width: 20, height: 20, shape: const Circle()), 'code': 'en', 'name': 'English'},
      {'icon': CountryFlag.fromCountryCode('nl', width: 20, height: 20, shape: const Circle()), 'code': 'nl', 'name': 'Nederlands'},
      {'icon': CountryFlag.fromLanguageCode('fr', width: 20, height: 20, shape: const Circle()), 'code': 'fr', 'name': 'Français'},
      {'icon': CountryFlag.fromLanguageCode('de', width: 20, height: 20, shape: const Circle()), 'code': 'de', 'name': 'Deutsch'},
      {'icon': CountryFlag.fromLanguageCode('es', width: 20, height: 20, shape: const Circle()), 'code': 'es', 'name': 'Español'}
    ];

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Spacer(),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            underline: Container(),
            items: languages.map((lang) {
              return DropdownMenuItem<String>(
                value: lang['code'] as String?,
                child: Row(
                  children: [
                    lang['icon'] as Widget,
                    const SizedBox(width: 10),
                    Text((lang['code'] as String?)!.toUpperCase()),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}