import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/model/classroom.dart';
import 'package:seatly/model/configuration/layoutType/layout_type.dart';
import 'package:seatly/model/configuration/sortingOptions/different_sorting_options.dart';
import 'package:seatly/model/configuration/sortingOptions/sorting_option.dart';
import 'package:seatly/model/desk.dart';
import 'package:seatly/model/position.dart';
import 'package:seatly/repository/classroom/classroom_repository.dart';

import 'classroom_repository_test.mocks.dart';

@GenerateMocks([JsonWriteRead])
void main() {
  group('ClassroomRepository - all functions.', ()
  {
    late ClassroomRepository classroomRepository;
    late MockJsonWriteRead mockJsonWriteRead;

    setUp(() {
      mockJsonWriteRead = MockJsonWriteRead();
      classroomRepository =
          ClassroomRepository(jsonWriteRead: mockJsonWriteRead);
    });

    test('Returns null when classroom with given ID does not exist.', () async {
      final file = File('test.json');

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'classrooms': []});

      final classroom = await classroomRepository.loadClassroom('classroom1');
      expect(classroom, isNull);
    });

    test('Returns the correct classroom when given the classroom ID.', () async {
      final file = File('test.json');
      when(mockJsonWriteRead.getFile(any)).thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file)).thenAnswer((_) async =>
      {
        'classrooms': [
          {
            'id': 'classroom1',
            'name': 'Classroom 1',
            'layoutType': 'rowByRow',
            'desks': [
              {
                'id': 'seat1',
                'position': {'row': 1, 'column': 1},
                'isOccupied': false,
                'student': null
              },
              {
                'id': 'seat2',
                'position': {'row': 1, 'column': 2},
                'isOccupied': false,
                'student': null
              }
            ],
            'studentIds': ['student1', 'student2'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition'
              ]
            }
          },
          {
            'id': 'classroom2',
            'name': 'Classroom 2',
            'layoutType': 'specialUShape',
            'desks': [
              {
                'id': 'desk1',
                'position': {'row': 1, 'column': 1},
                'isOccupied': false,
                'student': null
              },
              {
                'id': 'desk2',
                'position': {'row': 1, 'column': 2},
                'isOccupied': false,
                'student': null
              }
            ],
            'studentIds': ['student3', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
        ]
      });

      final classroom = await classroomRepository.loadClassroom('classroom2');
      expect(classroom, isNotNull);
      expect(classroom?.id, 'classroom2');
      expect(classroom?.name, 'Classroom 2');
      expect(classroom?.desks.length, 2);
      expect(classroom?.studentIds.contains('student3'), true);
      expect(classroom?.sortingOptions.selectedOptions.contains(
          SortingOption.avoidSamePlaceRepetition), true);
    });

    test('Returns null when loading in all the classrooms because non exist.', () async {
      final file = File('test.json');
      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'classrooms': []});

      final classrooms = await classroomRepository.loadAllClassrooms();
      expect(classrooms, isEmpty);
    });

    test('Returns a complete list of classrooms that were present in the mocked file.', () async {
      final file = File('test.json');

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async =>
      {
        'classrooms': [
          {
            'id': 'classroom1',
            'name': 'Classroom 1',
            'layoutType': 'rowByRow',
            'desks': [
              {
                'id': 'seat1',
                'position': {'row': 1, 'column': 1},
                'isOccupied': false,
                'student': null
              },
              {
                'id': 'seat2',
                'position': {'row': 1, 'column': 2},
                'isOccupied': false,
                'student': null
              }
            ],
            'studentIds': ['student1', 'student2'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition'
              ]
            }
          },
          {
            'id': 'classroom2',
            'name': 'Classroom 2',
            'layoutType': 'specialUShape',
            'desks': [
              {
                'id': 'desk1',
                'position': {'row': 1, 'column': 1},
                'isOccupied': false,
                'student': null
              },
              {
                'id': 'desk2',
                'position': {'row': 1, 'column': 2},
                'isOccupied': false,
                'student': null
              }
            ],
            'studentIds': ['student3', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
          {
            'id': 'classroom3',
            'name': 'Classroom 3',
            'layoutType': 'specialUShape',
            'desks': [
              {
                'id': 'desk1',
                'position': {'row': 1, 'column': 1},
                'isOccupied': false,
                'student': null
              },
              {
                'id': 'desk2',
                'position': {'row': 1, 'column': 2},
                'isOccupied': false,
                'student': null
              }
            ],
            'studentIds': ['student5', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
        ]
      });

      final classrooms = await classroomRepository.loadAllClassrooms();
      expect(classrooms.length, 3);
      expect(classrooms[0].id, 'classroom1');
      expect(classrooms[2].id, 'classroom3');
      expect(classrooms[2].sortingOptions.selectedOptions.contains(
          SortingOption.avoidSameNationality), true);
      expect(classrooms[1].desks[1].position.row, 1);
      expect(classrooms[1].desks[1].position.column, 2);
    });

    test('Saves the classroom given correctly.', () async {
      final file = File('test.json');
      final classroom = Classroom(
          id: 'classroom1',
          name: 'Classroom 1',
          layoutType: LayoutType.groupedLayout,
          desks: [
            Desk(
                id: 'desk1',
                position: Position(row: 1, column: 1),
                assignedStudentId: 'student1',
                previousStudentId: 'student2'
            ),
            Desk(
                id: 'desk2',
                position: Position(row: 1, column: 2),
                assignedStudentId: 'student2',
                previousStudentId: 'student1'
            )
          ],
          studentIds: ['student1', 'student2'],
          sortingOptions: DifferentSortingOptions(
              selectedOptions: [
                SortingOption.avoidSameNationality,
                SortingOption.avoidAdjacentRepetition
              ]
          )
      );

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'classrooms': []});
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      await classroomRepository.saveClassroom(classroom);
      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, {
        'classrooms': [classroom.toJson()]
      })).called(1);
    });

    test('Saves all the given classrooms correctly.', () async {
      final file = File('test.json');
      final classrooms = [
        Classroom(
            id: 'classroom1',
            name: 'Classroom 1',
            layoutType: LayoutType.groupedLayout,
            desks: [
              Desk(
                  id: 'desk1',
                  position: Position(row: 1, column: 1),
                  assignedStudentId: 'student1',
                  previousStudentId: 'student2'),
              Desk(
                  id: 'desk2',
                  position: Position(row: 1, column: 2),
                  assignedStudentId: 'student2',
                  previousStudentId: 'student1')
            ],
            studentIds: ['student1', 'student2'],
            sortingOptions: DifferentSortingOptions(selectedOptions: [
              SortingOption.avoidSameNationality,
              SortingOption.avoidAdjacentRepetition
            ])
        ),
        Classroom(
            id: 'classroom2',
            name: 'Classroom 2',
            layoutType: LayoutType.labLayout,
            desks: [
              Desk(
                  id: 'desk1',
                  position: Position(row: 1, column: 1),
                  assignedStudentId: 'student3',
                  previousStudentId: 'student4'),
              Desk(
                  id: 'desk2',
                  position: Position(row: 1, column: 2),
                  assignedStudentId: 'student4',
                  previousStudentId: 'student3')
            ],
            studentIds: ['student3', 'student4'],
            sortingOptions: DifferentSortingOptions(selectedOptions: [
              SortingOption.avoidSameNationality,
              SortingOption.avoidAdjacentRepetition
            ])
        )
      ];

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => {'classrooms': []});
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      await classroomRepository.saveAllClassrooms(classrooms);
      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, {
        'classrooms': classrooms.map((e) => e.toJson()).toList()
      })).called(1);
    });

    test('Deletes the classroom that corresponds with the given ID successfully.', () async {
      final file = File('test.json');

      final initialData = {
        'classrooms': [
          {
            'id': 'classroom1',
            'name': 'Classroom 1',
            'layoutType': 'rowByRow',
            'desks': [
              {'id': 'seat1', 'position': {'row': 1, 'column': 1}},
              {'id': 'seat2', 'position': {'row': 1, 'column': 2}}
            ],
            'studentIds': ['student1', 'student2'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition'
              ]
            }
          },
          {
            'id': 'classroom2',
            'name': 'Classroom 2',
            'layoutType': 'specialUShape',
            'desks': [
              {'id': 'desk1', 'position': {'row': 1, 'column': 1}},
              {'id': 'desk2', 'position': {'row': 1, 'column': 2}}
            ],
            'studentIds': ['student3', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
          {
            'id': 'classroom3',
            'name': 'Classroom 3',
            'layoutType': 'specialUShape',
            'desks': [
              {'id': 'desk1', 'position': {'row': 1, 'column': 1}},
              {'id': 'desk2', 'position': {'row': 1, 'column': 2}}
            ],
            'studentIds': ['student5', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
        ]
      };
      final updatedData = {
        'classrooms': [
          {
            'id': 'classroom2',
            'name': 'Classroom 2',
            'layoutType': 'specialUShape',
            'desks': [
              {'id': 'desk1', 'position': {'row': 1, 'column': 1}, 'assignedStudentId': null, 'previousStudentId': null},
              {'id': 'desk2', 'position': {'row': 1, 'column': 2}, 'assignedStudentId': null, 'previousStudentId': null}
            ],
            'studentIds': ['student3', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
          {
            'id': 'classroom3',
            'name': 'Classroom 3',
            'layoutType': 'specialUShape',
            'desks': [
              {'id': 'desk1', 'position': {'row': 1, 'column': 1}, 'assignedStudentId': null, 'previousStudentId': null},
              {'id': 'desk2', 'position': {'row': 1, 'column': 2}, 'assignedStudentId': null, 'previousStudentId': null}
            ],
            'studentIds': ['student5', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          },
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      await classroomRepository.deleteClassroom('classroom1');

      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, updatedData)).called(1);
    });

    test('Updates the classroom successfully.', () async {
      final file = File('test.json');
      final initialData = {
        'classrooms': [
          {
            'id': 'classroom1',
            'name': 'Classroom 1',
            'layoutType': 'rowByRow',
            'desks': [
              {
                'id': 'seat1',
                'position': {'row': 1, 'column': 1}
              },
              {
                'id': 'seat2',
                'position': {'row': 1, 'column': 2}
              }
            ],
            'studentIds': ['student1', 'student2'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition'
              ]
            }
          },
          {
            'id': 'classroom2',
            'name': 'Classroom 2',
            'layoutType': 'specialUShape',
            'desks': [
              {
                'id': 'desk1',
                'position': {'row': 1, 'column': 1}
              },
              {
                'id': 'desk2',
                'position': {'row': 1, 'column': 2}
              }
            ],
            'studentIds': ['student3', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          }
        ]
      };
      final updatedData = {
        'classrooms': [
          {
            'id': 'classroom1',
            'name': 'Classroom 1',
            'layoutType': 'uShape',
            'desks': [
              {
                'id': 'seat1',
                'position': {'row': 2, 'column': 3},
                'assignedStudentId': null,
                'previousStudentId': null
              },
              {
                'id': 'seat2',
                'position': {'row': 3, 'column': 2},
                'assignedStudentId': null,
                'previousStudentId': null
              }
            ],
            'studentIds': ['student1', 'student2', 'student3'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition'
              ]
            }
          },
          {
            'id': 'classroom2',
            'name': 'Classroom 2',
            'layoutType': 'specialUShape',
            'desks': [
              {
                'id': 'desk1',
                'position': {'row': 1, 'column': 1},
                'assignedStudentId': null,
                'previousStudentId': null
              },
              {
                'id': 'desk2',
                'position': {'row': 1, 'column': 2},
                'assignedStudentId': null,
                'previousStudentId': null
              }
            ],
            'studentIds': ['student3', 'student4'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition',
                'avoidSamePlaceRepetition'
              ]
            }
          }
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      final classroom = Classroom(
          id: 'classroom1',
          name: 'Classroom 1',
          layoutType: LayoutType.uShape,
          desks: [
            Desk(id: 'seat1', position: Position(row: 2, column: 3)),
            Desk(id: 'seat2', position: Position(row: 3, column: 2))
          ],
          studentIds: ['student1', 'student2', 'student3'],
          sortingOptions: DifferentSortingOptions(selectedOptions: [
            SortingOption.avoidSameNationality,
            SortingOption.avoidAdjacentRepetition
          ]));
      await classroomRepository.updateClassroom(classroom);

      verify(mockJsonWriteRead.getFile('classroomSeperator.json')).called(1);
      verify(mockJsonWriteRead.readDataFromFile(file)).called(1);
      verify(mockJsonWriteRead.writeDataToFile(file, updatedData)).called(1);
    });

    test('Throws an exception when the classroom is not found.', () async {
      final file = File('test.json');
      final initialData = {
        'classrooms': [
          {
            'id': 'classroom1',
            'name': 'Classroom 1',
            'layoutType': 'rowByRow',
            'desks': [
              {
                'id': 'seat1',
                'position': {'row': 1, 'column': 1},
                'assignedStudentId': null,
                'previousStudentId': null
              },
              {
                'id': 'seat2',
                'position': {'row': 1, 'column': 2},
                'assignedStudentId': null,
                'previousStudentId': null
              }
            ],
            'studentIds': ['student1', 'student2'],
            'sortingOptions': {
              'selectedOptions': [
                'avoidSameNationality',
                'avoidAdjacentRepetition'
              ]
            }
          }
        ]
      };

      when(mockJsonWriteRead.getFile(any))
          .thenAnswer((_) async => file);
      when(mockJsonWriteRead.readDataFromFile(file))
          .thenAnswer((_) async => initialData);
      when(mockJsonWriteRead.writeDataToFile(any, any))
          .thenAnswer((_) async => {});

      final classroom = Classroom(
          id: 'classroom2',
          name: 'Classroom 2',
          layoutType: LayoutType.uShape,
          desks: [
            Desk(id: 'seat1', position: Position(row: 2, column: 3)),
            Desk(id: 'seat2', position: Position(row: 3, column: 2))
          ],
          studentIds: ['student1', 'student2', 'student3'],
          sortingOptions: DifferentSortingOptions(selectedOptions: [
            SortingOption.avoidSameNationality,
            SortingOption.avoidAdjacentRepetition
          ]));

      expect(
          () async => await classroomRepository.updateClassroom(classroom),
          throwsA(isA<Exception>().having((e) => e.toString(), 'description',
              'Exception: Classroom with id ${classroom.id} not found')));
    });
  });
}