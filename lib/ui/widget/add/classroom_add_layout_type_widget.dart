import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final String path;
  final Color color;

  const CategoryCard({
    super.key,
    required this.label,
    required this.path,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color
              ),
              child: Image.asset(path, fit: BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}