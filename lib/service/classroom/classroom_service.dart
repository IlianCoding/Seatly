import 'package:injectable/injectable.dart';
import 'package:seatly/domain/classroom.dart';

import 'package:seatly/repository/classroom/i_classroom_repository.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/ui/model/classroomdetail_model.dart';

@Singleton(as: IClassroomService)
class ClassroomService implements IClassroomService{
  final IClassroomRepository classroomRepository;
  final IStudentRepository studentRepository;

  ClassroomService({required this.classroomRepository, required this.studentRepository});

  @override
  Future<List<Classroom>> getAllClassrooms() async {
    return await classroomRepository.readAllClassrooms();
  }

  @override
  Future<ClassroomDetailsModel> getClassroomWithStudents(String classroomId) async{
    try {
      final classroom = await classroomRepository.readClassroom(classroomId);
      final students = await studentRepository.readAllStudents();
      final assignedStudents = students.where((student) => classroom!.studentIds.contains(student.id)).toList();

      if (classroom == null) {
        throw Exception('Classroom not found');
      }

      return ClassroomDetailsModel(classroom: classroom, students: assignedStudents);
    } catch (e) {
      throw Exception('Classroom not found $e');
    }
  }

  @override
  Future<void> addClassroom(Classroom classroom) async {
    return await classroomRepository.createClassroom(classroom);
  }

  @override
  Future<void> changeClassroom(Classroom classroom) async {
    return await classroomRepository.updateClassroom(classroom);
  }

  @override
  Future<void> removeClassroom(String classroomId) async {
    try {
      final classroom = await classroomRepository.readClassroom(classroomId);
      if (classroom == null) {
        throw Exception('Classroom not found');
      }

      for(final studentId in classroom.studentIds){
        await studentRepository.deleteStudent(studentId);
      }
      await classroomRepository.deleteClassroom(classroomId);
    } catch (e) {
      throw Exception('Failed to delete classroom and its students: $e');
    }
  }

  @override
  Future<void> initializeData() async {
    await studentRepository.initializeStudents();
    await classroomRepository.initializeClassrooms();
  }

  @override
  Future<void> assigningStudentsToDesks(Classroom classroom) async {
    // TODO: implement assigningStudentsToDesks
    throw UnimplementedError();
  }
}