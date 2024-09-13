import 'package:injectable/injectable.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/model/student.dart';

@Singleton(as: IStudentRepository)
class StudentRepository implements IStudentRepository {
  final String fileName = 'classroomSeperator.json';
  final JsonWriteRead _jsonWriteRead;

  StudentRepository({
    required JsonWriteRead jsonWriteRead,
  }) : _jsonWriteRead = jsonWriteRead;

  @override
  Future<Student?> loadStudent(String id) async {
    final file = await _jsonWriteRead.getFile(fileName);
  }

  @override
  Future<List<Student>> loadAllStudents() async {
    return [];
  }

  @override
  Future<void> saveStudent(Student student) async {
  }

  @override
  Future<void> updateStudent(Student student) async {
  }

  @override
  Future<void> deleteStudent(String id) async {
  }

  @override
  Future<void> saveAllStudents(List<Student> students) async {
  }

  @override
  Future<void> initializeStudents() async {
  }

  List<Student> _parseStudents(Map<String, dynamic> data) {
    final studentsJson = data['students'] as List<dynamic>?;
    if(studentsJson == null){
      return [];
    }
    return studentsJson.map((e) => Student.fromJson(e as Map<String, dynamic>)).toList();
  }
}