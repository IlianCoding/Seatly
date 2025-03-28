import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/service/student/i_student_service.dart';
import 'package:seatly/ui/model/desk_details_model.dart';

class DeskDetailPageViewModel extends StateNotifier<AsyncValue<DeskDetailsModel>> {
  final IStudentService studentService;

  DeskDetailPageViewModel(this.studentService) : super(const AsyncValue.loading());

  Future<void> fetchStudentDetails(String studentId) async {
    try {
      state = AsyncValue.loading();
      final student = await studentService.getStudentById(studentId);
      final deskDetails = DeskDetailsModel(
          studentId: student!.id,
          studentName: student.fullName,
          studentNationality: student.nationality,
          studentImageUri: student.imageUri,
          studentAge: student.age,
          studentHasSpecialNeeds: student.hasSpecialNeeds
      );
      state = AsyncValue.data(deskDetails);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}