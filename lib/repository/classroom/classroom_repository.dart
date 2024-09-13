import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:seatly/repository/classroom/i_classroom_repository.dart';
import 'package:seatly/model/classroom.dart';

@Singleton(as: IClassroomRepository)
class ClassroomRepository implements IClassroomRepository{
  final String fileName = 'classroomSeperator.json';

  @override
  Future<Classroom?> loadClassroom(String id) async {
    return null;
  }

  @override
  Future<List<Classroom>> loadAllClassrooms() async {
    return [];
  }

  @override
  Future<void> saveClassroom(Classroom classroom) async {

  }

  @override
  Future<void> updateClassroom(Classroom classroom) async {

  }

  @override
  Future<void> deleteClassroom(String id) async {

  }

  @override
  Future<void> saveAllClassrooms(List<Classroom> classrooms) async {

  }

  @override
  Future<void> initializeClassrooms() async {

  }
}