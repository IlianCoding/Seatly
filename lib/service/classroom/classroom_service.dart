import 'package:injectable/injectable.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/domain/desk.dart';
import 'package:seatly/domain/position.dart';

import 'package:seatly/repository/classroom/i_classroom_repository.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/ui/model/classroom_detail_model.dart';
import 'package:uuid/uuid.dart';

@Singleton(as: IClassroomService)
class ClassroomService implements IClassroomService{
  final IClassroomRepository classroomRepository;
  final IStudentRepository studentRepository;
  final Uuid uuid = const Uuid();

  ClassroomService({required this.classroomRepository, required this.studentRepository});

  @override
  Future<List<Classroom>> getAllClassrooms() async {
    return await classroomRepository.readAllClassrooms();
  }

  @override
  Future<List<String>> getAllClassroomIds() async {
    final classrooms = await classroomRepository.readAllClassrooms();
    return classrooms.map((classroom) => classroom.id).toList();
  }

  @override
  Future<ClassroomDetailsModel> getClassroomWithStudents(String classroomId) async{
    try {
      final classroom = await classroomRepository.readClassroom(classroomId);
      final students = await studentRepository.readAllStudents();
      final assignedStudents = students.where((student) => classroom!.studentIds.contains(student.id)).toList();

      if (classroom == null) {
        throw Exception('Classroom not found');
      }

      return ClassroomDetailsModel(classroom: classroom, students: assignedStudents);
    } catch (e) {
      throw Exception('Classroom not found $e');
    }
  }

  @override
  Future<void> addClassroom(Classroom classroom, int totalDesks, int? totalRows, int? amountOfDesksPerGroup, int? totalMiddleDesks, int? totalMiddleRow) async {
    classroom.id = await generateUniqueId();
    classroom.desks = await generateDesks(classroom, totalDesks, totalRows, amountOfDesksPerGroup, totalMiddleDesks, totalMiddleRow);
    return await classroomRepository.createClassroom(classroom);
  }

  @override
  Future<void> changeClassroom(Classroom classroom, int? totalDesks, int? totalRows, int? amountOfDesksPerGroup, int? totalMiddleDesks, int? totalMiddleRow) async {
    if (totalDesks != null){
      classroom.desks = await generateDesks(classroom, totalDesks, totalRows, amountOfDesksPerGroup, totalMiddleDesks, totalMiddleRow);
    }
    return await classroomRepository.updateClassroom(classroom);
  }

  @override
  Future<void> removeStudentFromClassroom(Classroom classroom, String studentId) async {

  }

  @override
  Future<void> removeClassroom(String classroomId) async {
    try {
      final classroom = await classroomRepository.readClassroom(classroomId);
      if (classroom == null) {
        throw Exception('Classroom not found');
      }

      for(final studentId in classroom.studentIds){
        await studentRepository.deleteStudent(studentId);
      }
      await classroomRepository.deleteClassroom(classroomId);
    } catch (e) {
      throw Exception('Failed to delete classroom and its students: $e');
    }
  }

  @override
  Future<void> initializeData() async {
    await studentRepository.initializeStudents();
    await classroomRepository.initializeClassrooms();
  }

  Future<String> generateUniqueId() async {
    final existingIds = await getAllClassroomIds();
    String newId;
    do {
      newId = uuid.v4();
    } while (existingIds.contains(newId));
    return newId;
  }

  Future<List<Desk>> generateDesks(Classroom classroom, int totalDesks, int? totalRows, int? amountOfDesksPerGroup, int? totalMiddleDesks, int? totalMiddleRow) async {
    List<Desk> desks = [];
    switch (classroom.layoutType) {
      case LayoutType.rowByRow:
        desks.addAll(await generateRowLayoutDesks(totalDesks, totalRows!));
        break;
      case LayoutType.groupedLayout:
        desks.addAll(await generateGroupLayoutDesks(totalDesks, amountOfDesksPerGroup!));
        break;
      case LayoutType.labLayout:
        desks.addAll(await generateGroupLayoutDesks(totalDesks, amountOfDesksPerGroup!));
        break;
      case LayoutType.uShape:
        desks.addAll(await generateUShapeLayoutDesks(totalDesks));
        break;
      case LayoutType.specialUShape:
        desks.addAll(await generateSpecialUShapeLayoutDesks(totalDesks, totalMiddleDesks!, totalMiddleRow!));
        break;
      default:
        desks.addAll(await generateUShapeLayoutDesks(totalDesks));
        break;
    }
    return desks;
  }

  Future<List<Desk>> generateRowLayoutDesks(int totalAmountDesks, int totalRows) async {
    int totalDesks = totalAmountDesks;
    int rows = totalRows;
    int desksPerRow = (totalDesks / rows).ceil();

    List<Desk> desks = [];
    for (int i = 0; i < totalDesks; i++) {
      int row = i ~/ desksPerRow;
      int column = i % desksPerRow;
      desks.add(
          Desk(id: "desk$i", position: Position(row: row, column: column)));
    }

    return desks;
  }

  Future<List<Desk>> generateGroupLayoutDesks(int totalAmountDesks, int amountOfDesksPerGroup) async {
    int totalDesks = totalAmountDesks;
    int desksPerGroup = amountOfDesksPerGroup;

    List<Desk> desks = [];
    for (int i = 0; i < totalDesks; i++) {
      int group = i ~/ desksPerGroup;
      int positionInGroup = i % desksPerGroup;
      desks.add(Desk(
          id: "desk$i",
          position: Position(row: group, column: positionInGroup)));
    }

    return desks;
  }

  Future<List<Desk>> generateUShapeLayoutDesks(int totalAmountDesks) async {
    int totalDesks = totalAmountDesks;

    List<Desk> desks = [];
    for (int i = 0; i < totalDesks; i++) {
      desks.add(
          Desk(id: "desk$i", position: Position(row: 0, column: i)));
    }

    return desks;
  }

  Future<List<Desk>> generateSpecialUShapeLayoutDesks(int totalAmountDesks, int totalMiddleDesks, int totalMiddleRows) async {
    int totalDesks = totalAmountDesks;
    int middleDesks = totalMiddleDesks;
    int middleRows = totalMiddleRows;
    int outerDesks = totalDesks - middleDesks;
    int desksPerRow = (middleDesks / middleRows).ceil();

    List<Desk> desks = [];
    for (int i = 0; i < outerDesks; i++) {
      desks.add(Desk(id: "desk$i", position: Position(row: 0, column: i)));
    }

    for (int i = 0; i < middleDesks; i++) {
      int row = (i ~/ desksPerRow) + 1;
      int column = i % desksPerRow;
      desks.add(Desk(id: "desk${outerDesks + i}", position: Position(row: row, column: column)));
    }

    return desks;
  }

  @override
  Future<void> assigningStudentsToDesks(Classroom classroom) async {
    // TODO: implement assigningStudentsToDesks
    throw UnimplementedError();
  }
}