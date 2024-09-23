import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/domain/classroom.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';

class ClassroomHomepageViewModel extends StateNotifier<AsyncValue<List<Classroom>>> {
  final IClassroomService classroomService;

  ClassroomHomepageViewModel(this.classroomService) : super(const AsyncLoading()) {
    loadClassrooms();
  }

  Future<void> loadClassrooms() async {
    try {
      await classroomService.initializeData();
      final classrooms = await classroomService.getAllClassrooms();
      state = AsyncData(classrooms);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}