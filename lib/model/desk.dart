import 'package:json_annotation/json_annotation.dart';

import 'package:seatly/model/position.dart';
import 'package:seatly/model/student.dart';

part 'desk.g.dart';

@JsonSerializable()
class Desk {
  final String id;
  final Position position;
  String? assignedStudentId;
  String? previousStudentId;

  Desk({
    required this.id,
    required this.position,
    this.assignedStudentId,
    this.previousStudentId,
  });

  bool get isAvailable => assignedStudentId == null;

  void assignStudent(Student student) {
    previousStudentId = assignedStudentId;
    assignedStudentId = student.id;
  }

  void clearAssignment() {
    previousStudentId = assignedStudentId;
    assignedStudentId = null;
  }

  Student? getAssignedStudent(Map<String, Student> studentMap) {
    return assignedStudentId != null ? studentMap[assignedStudentId!] : null;
  }

  Student? getPreviousStudent(Map<String, Student> studentMap) {
    return previousStudentId != null ? studentMap[previousStudentId!] : null;
  }

  // JSON serialization
  factory Desk.fromJson(Map<String, dynamic> json) => _$DeskFromJson(json);
  Map<String, dynamic> toJson() => _$DeskToJson(this);
}