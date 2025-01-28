import 'package:seatly/domain/classroom.dart';
import 'package:seatly/ui/model/classroom_detail_model.dart';

abstract class IClassroomService {
  Future<List<Classroom>> getAllClassrooms();
  Future<List<String>> getAllClassroomIds();
  Future<ClassroomDetailsModel> getClassroomWithStudents(String classroomId);

  Future<void> addClassroom(Classroom classroom, int totalDesks, int? totalRows, int? amountOfDesksPerGroup, int? totalMiddleDesks, int? totalMiddleRow);
  Future<void> changeClassroom(Classroom classroom, int? totalDesks, int? totalRows, int? amountOfDesksPerGroup, int? totalMiddleDesks, int? totalMiddleRow);
  Future<void> removeStudentFromClassroom(Classroom classroom, String studentId);
  Future<void> removeClassroom(String classroomId);

  Future<void> initializeData();

  Future<void> assigningStudentsToDesks(Classroom classroom);
}