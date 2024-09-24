import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/domain/student.dart';
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

      final student = await studentRepository.readStudent('student1');
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

      final student = await studentRepository.readStudent('student1');
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

      final students = await studentRepository.readAllStudents();
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

      final students = await studentRepository.readAllStudents();

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

      await studentRepository.createStudent(student);
      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, {
        'students': [student.toJson()]
      })).called(1);
    });

    test('Saves all the given students correctly.', () async {
      final file = File('test.json');

      final students = [
        Student(
          id: 'student1',
          firstName: 'Ilian',
          lastName: 'Elst',
          nationality: 'Belgium',
          birthDate: DateTime(2001, 1, 1),
          imageUri: '',
          hasSpecialNeeds: false,
        ),
        Student(
          id: 'student2',
          firstName: 'Nina',
          lastName: 'Zahra',
          nationality: 'Iran',
          birthDate: DateTime(1998, 1, 1),
          imageUri: '',
          hasSpecialNeeds: true,
        )
      ];

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'students': []});
      when(mockJsonWriteRead.writeDataToFile(file, any))
          .thenAnswer((_) async => {});

      await studentRepository.createAllStudents(students);

      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, {
        'students': students.map((e) => e.toJson()).toList()
      })).called(1);
    });

    test('Throws an exception when the classroom is not found.', () async {
      final file = File('test.json');
      final initialData = {
        'students': [
          {
            'id': 'student1',
            'firstName': 'Ilian',
            'lastName': 'Elst',
            'nationality': 'Belgium',
            'imageUri': '',
            'birthDate': '2001-01-01',
            'hasSpecialNeeds': false
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
          {
            'id': 'student3',
            'firstName': 'Johnny',
            'lastName': 'Walker',
            'nationality': 'Scotland',
            'imageUri': '',
            'birthDate': '1999-01-01',
            'hasSpecialNeeds': false
          }
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      expect(() async => await studentRepository.deleteStudent('student4'),
          throwsA(isA<Exception>().having((e) => e.toString(), 'description',
              'Exception: Student with id student4 not found')));
    });

    test('Deletes the classroom that corresponds with the given ID successfully.', () async {
      final file = File('test.json');
      final initialData = {
        'students': [
          {
            'id': 'student1',
            'firstName': 'Ilian',
            'lastName': 'Elst',
            'nationality': 'Belgium',
            'imageUri': 'TEST',
            'birthDate': '2001-01-01',
            'hasSpecialNeeds': false
          },
          {
            'id': 'student2',
            'firstName': 'Nina',
            'lastName': 'Zahra',
            'nationality': 'Iran',
            'imageUri': 'TEST',
            'birthDate': '1998-01-01',
            'hasSpecialNeeds': true
          },
          {
            'id': 'student3',
            'firstName': 'Johnny',
            'lastName': 'Walker',
            'nationality': 'Scotland',
            'imageUri': 'TEST',
            'birthDate': '1999-01-01',
            'hasSpecialNeeds': false
          }
        ]
      };
      final updatedData = {
        'students': [
          {
            'id': 'student1',
            'firstName': 'Ilian',
            'lastName': 'Elst',
            'nationality': 'Belgium',
            'imageUri': 'TEST',
            'birthDate': '2001-01-01T00:00:00.000',
            'hasSpecialNeeds': false
          },
          {
            'id': 'student3',
            'firstName': 'Johnny',
            'lastName': 'Walker',
            'nationality': 'Scotland',
            'imageUri': 'TEST',
            'birthDate': '1999-01-01T00:00:00.000',
            'hasSpecialNeeds': false
          }
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      await studentRepository.deleteStudent('student2');

      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);

      final captured = verify(mockJsonWriteRead.writeDataToFile(captureAny, captureAny)).captured;
      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(captured[1], updatedData), isTrue);
    });

    test('Throws an exception when the student is not found.', () async {
      final file = File('test.json');
      final initialData = {
        'students': [
          {
            'id': 'student1',
            'firstName': 'Ilian',
            'lastName': 'Elst',
            'nationality': 'Belgium',
            'imageUri': 'TEST',
            'birthDate': '2001-01-01',
            'hasSpecialNeeds': false
          },
          {
            'id': 'student2',
            'firstName': 'Nina',
            'lastName': 'Zahra',
            'nationality': 'Iran',
            'imageUri': 'TEST',
            'birthDate': '1998-01-01',
            'hasSpecialNeeds': true
          }
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      final student = Student(
        id: 'student3',
        firstName: 'Johnny',
        lastName: 'Hipster',
        nationality: 'Ireland',
        birthDate: DateTime(1981, 6, 26),
        imageUri: 'TEST',
        hasSpecialNeeds: false,
      );

      expect(() async => await studentRepository.updateStudent(student),
          throwsA(isA<Exception>().having((e) => e.toString(), 'description',
              'Exception: Student with id ${student.id} not found')));
    });

    test('Updates the student successfully.', () async {
      final file = File('test.json');
      final initialData = {
        'students': [
          {
            'id': 'student1',
            'firstName': 'Ilian',
            'lastName': 'Elst',
            'nationality': 'Belgium',
            'imageUri': 'TEST',
            'birthDate': '2001-01-01',
            'hasSpecialNeeds': false
          },
          {
            'id': 'student2',
            'firstName': 'Nina',
            'lastName': 'Zahra',
            'nationality': 'Iran',
            'imageUri': 'TEST',
            'birthDate': '1998-01-01',
            'hasSpecialNeeds': true
          }
        ]
      };
      final updatedData = {
        'students': [
          {
            'id': 'student1',
            'firstName': 'Ilian',
            'lastName': 'Elst',
            'nationality': 'Belgium',
            'imageUri': 'TEST',
            'birthDate': '2001-01-01T00:00:00.000',
            'hasSpecialNeeds': false
          },
          {
            'id': 'student2',
            'firstName': 'Johnny',
            'lastName': 'Hipster',
            'nationality': 'Ireland',
            'imageUri': 'TEST',
            'birthDate': '1981-06-26T00:00:00.000',
            'hasSpecialNeeds': false
          }
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      final student = Student(
        id: 'student2',
        firstName: 'Johnny',
        lastName: 'Hipster',
        nationality: 'Ireland',
        birthDate: DateTime(1981, 6, 26),
        imageUri: 'TEST',
        hasSpecialNeeds: false,
      );
      await studentRepository.updateStudent(student);

      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);

      final captured = verify(mockJsonWriteRead.writeDataToFile(captureAny, captureAny)).captured;
      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(captured[1], updatedData), isTrue);
    });
  });
}