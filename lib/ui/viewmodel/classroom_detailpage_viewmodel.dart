import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/service/student/i_student_service.dart';
import 'package:seatly/ui/model/classroomdetail_model.dart';

class ClassroomDetailPageViewModel extends StateNotifier<AsyncValue<ClassroomDetailsModel>> {
  final IClassroomService classroomService;
  final IStudentService studentService;

  ClassroomDetailPageViewModel(this.classroomService, this.studentService) : super(const AsyncLoading());

  Future<void> loadClassroomDetails(String classroomId) async {
    try {
      final classroomDetails = await classroomService.getClassroomWithStudents(classroomId);
      state = AsyncValue.data(classroomDetails);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<void> updateClassroom() async {
    try {
      final updatedClassroom = state.value!.classroom;
      await classroomService.changeClassroom(updatedClassroom);
      state = AsyncValue.data(await classroomService.getClassroomWithStudents(updatedClassroom.id));
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      final updatedClassroom = state.value!.classroom.copyWith(
        studentIds: state.value!.classroom.studentIds.where((id) => id != studentId).toList()
      );
      await classroomService.changeClassroom(updatedClassroom);
      await studentService.removeStudent(studentId);
      state = AsyncValue.data(await classroomService.getClassroomWithStudents(state.value!.classroom.id));
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}