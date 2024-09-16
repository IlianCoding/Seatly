import 'package:injectable/injectable.dart';
import 'package:seatly/model/classroom.dart';
import 'package:seatly/model/student.dart';

import 'package:seatly/repository/classroom/i_classroom_repository.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';

@Singleton(as: IClassroomService)
class ClassroomService implements IClassroomService{
  final IClassroomRepository classroomRepository;
  final IStudentRepository studentRepository;

  ClassroomService({required this.classroomRepository, required this.studentRepository});

  @override
  Future<List<Classroom>> getAllClassrooms() {
    // TODO: implement getAllClassrooms
    throw UnimplementedError();
  }

  @override
  Future<MapEntry<Classroom?, List<Student>>> getClassroomWithStudents(String classroomId) {
    // TODO: implement getClassroomWithStudents
    throw UnimplementedError();
  }

  @override
  Future<void> createClassroom(Classroom classroom) {
    // TODO: implement saveClassroom
    throw UnimplementedError();
  }

  @override
  Future<void> changeClassroom(Classroom classroom) {
    // TODO: implement changeClassroom
    throw UnimplementedError();
  }

  @override
  Future<void> removeClassroom(String classroomId) {
    // TODO: implement removeClassroom
    throw UnimplementedError();
  }

  @override
  Future<void> initializeData() {
    // TODO: implement initializeData
    throw UnimplementedError();
  }

  @override
  Future<void> assigningStudentsToDesks(Classroom classroom) {
    // TODO: implement assigningStudentsToDesks
    throw UnimplementedError();
  }
}