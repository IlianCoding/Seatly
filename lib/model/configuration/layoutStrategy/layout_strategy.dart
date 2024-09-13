import 'package:seatly/model/classroom.dart';

abstract class LayoutStrategy {
  bool assignStudents(Classroom classroom);
}