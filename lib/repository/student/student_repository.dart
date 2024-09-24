import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/domain/student.dart';

@Singleton(as: IStudentRepository)
class StudentRepository implements IStudentRepository {
  final String fileName = 'classroomSeperator.json';
  final JsonWriteRead _jsonWriteRead;

  StudentRepository({
    required JsonWriteRead jsonWriteRead,
  }) : _jsonWriteRead = jsonWriteRead;

  @override
  Future<Student?> readStudent(String id) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);
    final students = _parseStudents(data);

    return students.firstWhereOrNull((student) => student.id == id);
  }

  @override
  Future<List<Student>> readAllStudents() async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    return _parseStudents(data);
  }

  @override
  Future<void> createStudent(Student student) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    if(!data.containsKey('students')){
      data['students'] = [];
    }

    data['students'].add(student.toJson());
    await _jsonWriteRead.writeDataToFile(file, data);
  }

  @override
  Future<void> updateStudent(Student student) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    if(!data.containsKey('students')){
      throw Exception('No students found');
    }

    final students = _parseStudents(data);
    final index = students.indexWhere((c) => c.id == student.id);

    if (index >= 0) {
      students[index] = student;
      data['students'] = students.map((e) => e.toJson().cast<String, Object>()).toList();
      await _jsonWriteRead.writeDataToFile(file, data);
    } else {
      throw Exception('Student with id ${student.id} not found');
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    if (!data.containsKey('students')) {
      throw Exception('No students found');
    }

    final students = _parseStudents(data);
    final index = students.indexWhere((c) => c.id == id);

    if (index >= 0) {
      students.removeAt(index);
      data['students'] = students.map((e) => e.toJson().cast<String, Object>()).toList();
      await _jsonWriteRead.writeDataToFile(file, data);
    } else {
      throw Exception('Student with id $id not found');
    }
  }

  @override
  Future<void> createAllStudents(List<Student> students) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    if(!data.containsKey('students')){
      data['students'] = [];
    }

    data['students'].addAll(students.map((e) => e.toJson()).toList());
    await _jsonWriteRead.writeDataToFile(file, data);
  }

  @override
  Future<void> initializeStudents() async {
    final students = [
      Student(id: 'student1', firstName: 'Ilian', lastName: 'Elst', nationality: 'Belgium', imageUri: '', birthDate: DateTime(2000, 1, 1), hasSpecialNeeds: false),
      Student(id: 'student2', firstName: 'John', lastName: 'Johnson', nationality: 'United States', imageUri: '', birthDate: DateTime(1967, 1, 1), hasSpecialNeeds: false),
      Student(id: 'student3', firstName: 'Maria', lastName: 'Garcia', nationality: 'Spain', imageUri: '', birthDate: DateTime(1999, 4, 15), hasSpecialNeeds: false),
      Student(id: 'student4', firstName: 'Chen', lastName: 'Wei', nationality: 'China', imageUri: '', birthDate: DateTime(1998, 5, 20), hasSpecialNeeds: false),
      Student(id: 'student5', firstName: 'Amina', lastName: 'Khan', nationality: 'Pakistan', imageUri: '', birthDate: DateTime(2001, 3, 10), hasSpecialNeeds: true),
      Student(id: 'student6', firstName: 'Liam', lastName: 'O’Brien', nationality: 'Ireland', imageUri: '', birthDate: DateTime(2002, 6, 23), hasSpecialNeeds: false),
      Student(id: 'student7', firstName: 'Sophie', lastName: 'Dubois', nationality: 'France', imageUri: '', birthDate: DateTime(2003, 7, 5), hasSpecialNeeds: false),
      Student(id: 'student8', firstName: 'Mateo', lastName: 'Rossi', nationality: 'Italy', imageUri: '', birthDate: DateTime(2000, 2, 14), hasSpecialNeeds: true),
      Student(id: 'student9', firstName: 'Ingrid', lastName: 'Berg', nationality: 'Sweden', imageUri: '', birthDate: DateTime(2001, 12, 1), hasSpecialNeeds: false),
      Student(id: 'student10', firstName: 'Pedro', lastName: 'Fernandez', nationality: 'Mexico', imageUri: '', birthDate: DateTime(1999, 9, 9), hasSpecialNeeds: false),
      Student(id: 'student11', firstName: 'Fatima', lastName: 'Al-Farsi', nationality: 'United Arab Emirates', imageUri: '', birthDate: DateTime(2000, 8, 30), hasSpecialNeeds: false),
      Student(id: 'student12', firstName: 'Lukas', lastName: 'Müller', nationality: 'Germany', imageUri: '', birthDate: DateTime(1998, 11, 11), hasSpecialNeeds: false),
      Student(id: 'student13', firstName: 'Yuki', lastName: 'Tanaka', nationality: 'Japan', imageUri: '', birthDate: DateTime(1997, 12, 25), hasSpecialNeeds: true),
      Student(id: 'student14', firstName: 'Ahmed', lastName: 'Hassan', nationality: 'Egypt', imageUri: '', birthDate: DateTime(2000, 7, 19), hasSpecialNeeds: false),
      Student(id: 'student15', firstName: 'Emily', lastName: 'Smith', nationality: 'Canada', imageUri: '', birthDate: DateTime(2001, 10, 21), hasSpecialNeeds: false),
      Student(id: 'student16', firstName: 'Nina', lastName: 'Ivanova', nationality: 'Russia', imageUri: '', birthDate: DateTime(2002, 11, 2), hasSpecialNeeds: false),
      Student(id: 'student17', firstName: 'Ali', lastName: 'Zahra', nationality: 'Lebanon', imageUri: '', birthDate: DateTime(1999, 6, 30), hasSpecialNeeds: true),
      Student(id: 'student18', firstName: 'Oscar', lastName: 'Nielsen', nationality: 'Denmark', imageUri: '', birthDate: DateTime(2000, 3, 5), hasSpecialNeeds: false),
    ];

    await createAllStudents(students);
  }

  List<Student> _parseStudents(Map<String, dynamic> data) {
    final studentsJson = data['students'] as List<dynamic>?;
    if(studentsJson == null){
      return [];
    }
    return studentsJson.map((e) => Student.fromJson(e as Map<String, dynamic>)).toList();
  }
}