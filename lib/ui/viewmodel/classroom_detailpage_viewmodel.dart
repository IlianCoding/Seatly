import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/ui/model/classroomdetail_model.dart';

class ClassroomDetailPageViewModel extends StateNotifier<AsyncValue<ClassroomDetailsModel>> {
  final IClassroomService classroomService;

  ClassroomDetailPageViewModel(this.classroomService) : super(const AsyncLoading());

  Future<void> loadClassroomDetails(String classroomId) async {
    try {
      final classroomDetails = await classroomService.getClassroomWithStudents(classroomId);
      state = AsyncValue.data(classroomDetails);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}