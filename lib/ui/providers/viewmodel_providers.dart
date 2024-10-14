import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/ui/model/classroom_add_model.dart';
import 'package:seatly/ui/model/classroomdetail_model.dart';
import 'package:seatly/ui/providers/service_providers.dart';
import 'package:seatly/ui/viewmodel/classroom_addpage_viewmodel.dart';
import 'package:seatly/ui/viewmodel/classroom_detailpage_viewmodel.dart';
import 'package:seatly/ui/viewmodel/classroom_homepage_viewmodel.dart';

final classroomHomepageViewModel = StateNotifierProvider<ClassroomHomepageViewModel, AsyncValue<List<Classroom>>>((ref) {
  final classroomService = ref.read(classroomServiceProvider);
  return ClassroomHomepageViewModel(classroomService);
});

final classroomAddPageViewModel = StateNotifierProvider<ClassroomAddPageViewModel, ClassroomAddModel>((ref) {
  final classroomService = ref.read(classroomServiceProvider);
  return ClassroomAddPageViewModel(classroomService);
});

final classroomDetailPageViewModel = StateNotifierProvider.family<ClassroomDetailPageViewModel, AsyncValue<ClassroomDetailsModel>, String>((ref, classroomId) {
  final classroomService = ref.read(classroomServiceProvider);
  final studentService = ref.read(studentServiceProvider);
  final viewModel = ClassroomDetailPageViewModel(classroomService, studentService);
  viewModel.loadClassroomDetails(classroomId);
  return viewModel;
});