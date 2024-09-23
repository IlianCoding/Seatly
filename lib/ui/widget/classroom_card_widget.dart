import 'package:flutter/material.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

class ClassroomCard extends StatelessWidget {
  final Classroom classroom;

  const ClassroomCard({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    final classroomImage = () {
      switch (classroom.layoutType) {
        case LayoutType.rowByRow:
          return 'assets/images/rowbyrow.png';
        case LayoutType.groupedLayout:
          return 'assets/images/grouped.png';
        case LayoutType.uShape:
          return 'assets/images/ushape.png';
        case LayoutType.labLayout:
          return 'assets/images/laboratory.png';
        case LayoutType.specialUShape:
          return 'assets/images/ushape.png';
        default:
          return 'assets/images/rowbyrow.png';
      }
    }();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Image.asset(classroomImage, width: 48.0, height: 48.0),
          const SizedBox(width: 16.0),
          Expanded(
              child: Text(
            classroom.name,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          )),
          const Icon(Icons.arrow_forward, size: 20)
        ],
      ),
    );
  }
}