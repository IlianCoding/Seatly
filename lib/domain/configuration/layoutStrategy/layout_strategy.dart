import 'package:seatly/domain/classroom.dart';

abstract class ILayoutStrategy {
  bool assignStudents(Classroom classroom);
}