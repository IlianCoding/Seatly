import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/service/student/i_student_service.dart';
import 'package:seatly/ui/model/classroom_detail_model.dart';

class ClassroomDetailPageViewModel extends StateNotifier<AsyncValue<ClassroomDetailsModel>> {
  final IClassroomService classroomService;
  final IStudentService studentService;
  final String classroomId;

  ClassroomDetailPageViewModel(this.classroomService, this.studentService, this.classroomId) : super(const AsyncValue.loading()) {
    loadClassroomDetails(classroomId);
  }

  Future<void> loadClassroomDetails(String classroomId) async {
    try {
      state = AsyncValue.loading();
      final classroomDetails = await classroomService.getClassroomWithStudents(classroomId);
      state = AsyncValue.data(classroomDetails);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<bool> updateClassroom() async {
    try {
      await classroomService.changeClassroom(state.value!.classroom!, state.value?.totalDesks,
          state.value?.totalRows, state.value?.amountOfDesksPerGroup, state.value?.totalMiddleDesks,
          state.value?.totalRows);
      await loadClassroomDetails(state.value!.classroom!.id);
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<void> deleteStudentFromClassroom(String studentId) async {
    try {
      await classroomService.removeStudentFromClassroom(state.value!.classroom!, studentId);
      await loadClassroomDetails(state.value!.classroom!.id);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}