import 'package:seatly/model/classroom.dart';
import 'package:seatly/model/student.dart';

abstract class IClassroomService {
  Future<List<Classroom>> getAllClassrooms();
  Future<MapEntry<Classroom?, List<Student>>> getClassroomWithStudents(String classroomId);

  Future<void> createClassroom(Classroom classroom);
  Future<void> changeClassroom(Classroom classroom);
  Future<void> removeClassroom(String classroomId);

  Future<void> initializeData();

  Future<void> assigningStudentsToDesks(Classroom classroom);
}