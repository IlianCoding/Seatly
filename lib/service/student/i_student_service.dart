import 'package:seatly/domain/student.dart';

abstract class IStudentService {
  Future<Student?> getStudentById(String id);
  Future<List<Student>> getAllStudents();

  Future<void> addStudent(Student student);
  Future<void> changeStudent(Student student);
  Future<void> removeStudent(String id);
}