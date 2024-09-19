import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/student.dart';

class ClassroomDetailsModel {
  final Classroom classroom;
  final List<Student> students;

  ClassroomDetailsModel({required this.classroom, required this.students});
}