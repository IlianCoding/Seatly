import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/ui/model/classroomdetail_model.dart';
import 'package:seatly/ui/providers/service_providers.dart';
import 'package:seatly/ui/viewmodel/classroom_detailpage_viewmodel.dart';
import 'package:seatly/ui/viewmodel/classroom_homepage_viewmodel.dart';

final classroomHomepageViewModel = StateNotifierProvider<ClassroomHomepageViewModel, AsyncValue<List<Classroom>>>((ref) {
  final classroomService = ref.read(classroomServiceProvider);
  return ClassroomHomepageViewModel(classroomService);
});

final classroomDetailPageViewModel = StateNotifierProvider.family<ClassroomDetailPageViewModel, AsyncValue<ClassroomDetailsModel>, String>((ref, classroomId) {
  final classroomService = ref.read(classroomServiceProvider);
  final viewModel = ClassroomDetailPageViewModel(classroomService);
  viewModel.loadClassroomDetails(classroomId);
  return viewModel;
});