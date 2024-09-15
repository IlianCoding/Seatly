import 'package:seatly/model/student.dart';

abstract class IStudentRepository{
  Future<Student?> loadStudent(String id);
  Future<List<Student>> loadAllStudents();

  Future<void> saveStudent(Student student);
  Future<void> updateStudent(Student student);
  Future<void> deleteStudent(String id);

  Future<void> saveAllStudents(List<Student> students);

  Future<void> initializeStudents();
}