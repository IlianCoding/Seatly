import 'package:flutter/material.dart';

class FontItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final double? value;
  final Function(double?) onChanged;

  const FontItem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final fontSizes = [12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0];

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
          DropdownButton<double>(
            value: value,
            onChanged: onChanged,
            underline: Container(),
            items: fontSizes.map((size) {
              return DropdownMenuItem<double>(
                value: size,
                child: Text(
                  'example',
                  style: TextStyle(fontSize: size),
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