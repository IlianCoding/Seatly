import 'package:seatly/domain/classroom.dart';

abstract class IClassroomRepository{
  Future<Classroom?> readClassroom(String id);
  Future<List<Classroom>> readAllClassrooms();

  Future<void> createClassroom(Classroom classroom);
  Future<void> updateClassroom(Classroom classroom);
  Future<void> deleteClassroom(String id);

  Future<void> createAllClassrooms(List<Classroom> classrooms);

  Future<void> initializeClassrooms();
}