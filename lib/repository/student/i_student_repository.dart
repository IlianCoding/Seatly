import 'package:seatly/domain/student.dart';

abstract class IStudentRepository{
  Future<Student?> readStudent(String id);
  Future<List<Student>> readAllStudents();

  Future<void> createStudent(Student student);
  Future<void> updateStudent(Student student);
  Future<void> deleteStudent(String id);

  Future<void> createAllStudents(List<Student> students);

  Future<void> initializeStudents();
}