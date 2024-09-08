import 'package:seatly/model/classroom.dart';

abstract class IClassroomRepository{
  Future<void> saveClassroom(Classroom classroom);

}