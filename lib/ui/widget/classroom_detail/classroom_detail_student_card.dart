import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String studentName;
  final String birthDate;
  final String imageUri;
  final Color color;

  const StudentCard({
    super.key,
    required this.studentName,
    required this.birthDate,
    required this.imageUri,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        children: [
          Image.asset(imageUri, width: 48.0, height: 48.0),
          const SizedBox(width: 24.0),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(studentName, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 8.0),
                  Text(birthDate, style: TextStyle(fontSize: 8.0, color: Colors.grey[700])),
                ],
              )
          ),
          const Icon(Icons.arrow_forward, size: 20, color: Colors.black)
        ],
      ),
    );
  }
}