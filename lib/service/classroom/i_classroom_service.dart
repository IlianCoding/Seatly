import 'package:seatly/domain/classroom.dart';
import 'package:seatly/ui/model/classroomdetail_model.dart';

abstract class IClassroomService {
  Future<List<Classroom>> getAllClassrooms();
  Future<List<String>> getAllClassroomIds();
  Future<ClassroomDetailsModel> getClassroomWithStudents(String classroomId);

  Future<void> addClassroom(Classroom classroom);
  Future<void> changeClassroom(Classroom classroom);
  Future<void> removeClassroom(String classroomId);

  Future<void> initializeData();

  Future<void> assigningStudentsToDesks(Classroom classroom);
}