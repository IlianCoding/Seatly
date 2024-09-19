import 'package:seatly/domain/classroom.dart';

abstract class LayoutStrategy {
  bool assignStudents(Classroom classroom);
}