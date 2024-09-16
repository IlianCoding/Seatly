import 'package:seatly/model/student.dart';

abstract class IStudentService {
  Future<Student?> getStudentById(int id);
  Future<List<Student>> getAllStudents();

  Future<void> createStudent(Student student);
  Future<void> changeStudent(Student student);
  Future<void> removeStudent(int id);
}