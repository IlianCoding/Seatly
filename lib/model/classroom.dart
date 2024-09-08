import 'configuration/layoutType/layout_type.dart';
import 'configuration/sortingOptions/different_sorting_options.dart';
import 'desk.dart';
import 'student.dart';

class Classroom {
  final String id;
  final String name;
  LayoutType layoutType;
  final List<Desk> desks;
  final List<String> studentIds;
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
}