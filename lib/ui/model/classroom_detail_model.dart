import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/student.dart';

class ClassroomDetailsModel {
  final Classroom? classroom;
  final List<Student>? students;
  final int? totalDesks;
  final int? totalRows;
  final int? amountOfDesksPerGroup;
  final int? totalMiddleDesks;

  ClassroomDetailsModel({
    this.classroom,
    this.students,
    this.totalDesks,
    this.totalRows,
    this.amountOfDesksPerGroup,
    this.totalMiddleDesks
  });

  ClassroomDetailsModel copyWith({
    Classroom? classroom,
    List<Student>? students,
    int? totalDesks,
    int? totalRows,
    int? amountOfDesksPerGroup,
    int? totalMiddleDesks,
  }) {
    return ClassroomDetailsModel(
      classroom: classroom ?? this.classroom,
      students: students ?? this.students,
      totalDesks: totalDesks ?? this.totalDesks,
      totalRows: totalRows ?? this.totalRows,
      amountOfDesksPerGroup: amountOfDesksPerGroup ?? this.amountOfDesksPerGroup,
      totalMiddleDesks: totalMiddleDesks ?? this.totalMiddleDesks
    );
  }

  Classroom? get classroomValue => classroom;
  List<Student>? get studentsValue => students;
  int? get totalDesksValue => totalDesks;
  int? get totalRowsValue => totalRows;
  int? get amountOfDesksPerGroupValue => amountOfDesksPerGroup;
  int? get totalMiddleDesksValue => totalMiddleDesks;
}