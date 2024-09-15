import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/model/student.dart';
import 'package:seatly/repository/student/student_repository.dart';

import 'student_repository_test.mocks.dart';

@GenerateMocks([JsonWriteRead])
void main() {
  group('StudentRepository - all functions.', () {
    late StudentRepository studentRepository;
    late MockJsonWriteRead mockJsonWriteRead;

    setUp(() {
      mockJsonWriteRead = MockJsonWriteRead();
      studentRepository = StudentRepository(jsonWriteRead: mockJsonWriteRead);
    });

    test('Returns null when student with given ID does not exist.', () async {
      final file = File('test.json');

      when(mockJsonWriteRead.getFile(any)).thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'students': []});

      final student = await studentRepository.loadStudent('student1');
      expect(student, isNull);
    });

    test('Returns the correct student when given the student ID.', () async {
      final file = File('test.json');

      when(mockJsonWriteRead.getFile(any)).thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file)).thenAnswer((_) async => {
            'students': [
              {
                'id': 'student1',
                'firstName': 'Ilian',
                'lastName': 'Elst',
                'nationality': 'Belgium',
                'imageUri': '',
                'birthDate': '2001-01-01',
                'hasSpecialNeeds': false,
              },
              {
                'id': 'student2',
                'firstName': 'Nina',
                'lastName': 'Zahra',
                'nationality': 'Iran',
                'imageUri': '',
                'birthDate': '1998-01-01',
                'hasSpecialNeeds': true
              }
            ]
          });

      final student = await studentRepository.loadStudent('student1');
      expect(student, isNotNull);
      expect(student!.id, 'student1');
      expect(student.firstName, 'Ilian');
      expect(student.lastName, 'Elst');
      expect(student.nationality, 'Belgium');
      expect(student.birthDate, DateTime(2001, 1, 1));
      expect(student.hasSpecialNeeds, false);
    });

    test('Returns null when loading in all students because non exist.', () async {
      final file = File('test.json');

      when(mockJsonWriteRead.getFile(any)).thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'students': []});

      final students = await studentRepository.loadAllStudents();
      expect(students, isEmpty);
    });

    test('Returns a complete list of students that were present in the mocked file.', () async {
      final file = File('test.json');

      when(mockJsonWriteRead.getFile(any)).thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file)).thenAnswer((_) async => {
            'students': [
              {
                'id': 'student1',
                'firstName': 'Ilian',
                'lastName': 'Elst',
                'nationality': 'Belgium',
                'imageUri': '',
                'birthDate': '2001-01-01',
                'hasSpecialNeeds': false,
              },
              {
                'id': 'student2',
                'firstName': 'Nina',
                'lastName': 'Zahra',
                'nationality': 'Iran',
                'imageUri': '',
                'birthDate': '1998-01-01',
                'hasSpecialNeeds': true
              },
            ]
          });

      final students = await studentRepository.loadAllStudents();

      expect(students.length, 2);
      expect(students[0].id, 'student1');
      expect(students[1].id, 'student2');
    });

    test('Saves the student given correctly.', () async {
      final file = File('test.json');
      final student = Student(
        id: 'student1',
        firstName: 'Ilian',
        lastName: 'Elst',
        nationality: 'Belgium',
        birthDate: DateTime(2001, 1, 1),
        imageUri: '',
        hasSpecialNeeds: false,
      );

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'students': []});
      when(mockJsonWriteRead.writeDataToFile(file, any))
          .thenAnswer((_) async => {});

      await studentRepository.saveStudent(student);
      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, {
        'students': [student.toJson()]
      })).called(1);
    });
  });
}