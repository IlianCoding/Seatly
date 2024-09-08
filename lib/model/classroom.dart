import 'package:json_annotation/json_annotation.dart';

import 'configuration/layoutType/layout_type.dart';
import 'configuration/sortingOptions/different_sorting_options.dart';
import 'desk.dart';
import 'student.dart';

part 'classroom.g.dart';

@JsonSerializable()
class Classroom {
  final String id;
  final String name;
  @JsonKey(name: 'layoutType')
  LayoutType layoutType;
  final List<Desk> desks;
  @JsonKey(name: 'studentIds')
  final List<String> studentIds;
  @JsonKey(name: 'sortingOptions')
  DifferentSortingOptions sortingOptions;

  Classroom({
    required this.id,
    required this.name,
    required this.layoutType,
    required this.desks,
    required this.studentIds,
    DifferentSortingOptions? sortingOptions,
  }) : sortingOptions = sortingOptions ?? DifferentSortingOptions();

  void updateLayoutStrategy(LayoutType type) {
    layoutType = type;
  }

  void updateSortingOptions(DifferentSortingOptions options) {
    sortingOptions = options;
  }

  void clearAssignments() {
    for (var desk in desks) {
      desk.clearAssignment();
    }
    studentIds.clear();
  }

  //TODO: Change this so it returns a list of students from the .json file
  List<Student> getStudents(List<Student> studentList) {
    return studentIds
        .map((studentId) => studentList.firstWhere(
          (student) => student.id == studentId,
      orElse: () => Student(
        id: '',
        firstName: '',
        lastName: '',
        nationality: '',
        imageUri: '',
        birthDate: DateTime.now(),
      ),
    ))
        .where((student) => student.id.isNotEmpty)
        .toList();
  }

  // JSON serialization
  factory Classroom.fromJson(Map<String, dynamic> json) => _$ClassroomFromJson(json);
  Map<String, dynamic> toJson() => _$ClassroomToJson(this);
}