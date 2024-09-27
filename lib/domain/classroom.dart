import 'package:json_annotation/json_annotation.dart';

import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/domain/configuration/sortingOptions/different_sorting_options.dart';
import 'package:seatly/domain/desk.dart';

part 'classroom.g.dart';

@JsonSerializable(explicitToJson: true)
class Classroom {
  String id;
  String name;
  @JsonKey(name: 'layoutType')
  LayoutType layoutType;
  List<Desk> desks;
  @JsonKey(name: 'studentIds')
  List<String> studentIds;
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

  Classroom copyWith({
    String? id,
    String? name,
    LayoutType? layoutType,
    List<Desk>? desks,
    List<String>? studentIds,
    DifferentSortingOptions? sortingOptions,
  }) {
    return Classroom(
      id: id ?? this.id,
      name: name ?? this.name,
      layoutType: layoutType ?? this.layoutType,
      desks: desks ?? this.desks,
      studentIds: studentIds ?? this.studentIds,
      sortingOptions: sortingOptions ?? this.sortingOptions,
    );
  }

  void addDesk(Desk desk){
    desks.add(desk);
  }

  void addStudent(String studentId){
    studentIds.add(studentId);
  }

  void updateName(String updatedName){
    name = updatedName;
  }

  void updateLayoutStrategy(LayoutType updatedType) {
    layoutType = updatedType;
  }

  void updateDesks(List<Desk> updatedDesks){
    for(var updatedDesk in updatedDesks){
      final index = desks.indexWhere((desk) => desk.id == updatedDesk.id);
      if(index != -1){
        desks[index] = updatedDesk;
      } else {
        desks.add(updatedDesk);
      }
    }
  }

  void updateStudentIds(List<String> updatedStudentIds) {
    for (var updatedStudentId in updatedStudentIds) {
      if (!studentIds.contains(updatedStudentId)) {
        studentIds.add(updatedStudentId);
      }
    }
  }

  void updateSortingOptions(DifferentSortingOptions updatedOptions) {
    sortingOptions = updatedOptions;
  }

  void removeDesk(String deskId){
    desks.removeWhere((desk) => desk.id == deskId);
  }

  void removeStudent(String studentId){
    studentIds.remove(studentId);
  }

  void clearAssignments() {
    for (var desk in desks) {
      desk.clearAssignment();
    }
    studentIds.clear();
  }

  factory Classroom.fromJson(Map<String, dynamic> json) => _$ClassroomFromJson(json);
  Map<String, dynamic> toJson() => _$ClassroomToJson(this);
}