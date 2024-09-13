import 'package:seatly/model/classroom.dart';

abstract class IClassroomRepository{
  Future<Classroom?> loadClassroom(String id);
  Future<List<Classroom>> loadAllClassrooms();

  Future<void> saveClassroom(Classroom classroom);
  Future<void> updateClassroom(Classroom classroom);
  Future<void> deleteClassroom(String id);

  Future<void> saveAllClassrooms(List<Classroom> classrooms);

  Future<void> initializeClassrooms();
}