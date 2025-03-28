import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/ui/model/classroom_add_model.dart';
import 'package:seatly/ui/model/classroom_detail_model.dart';
import 'package:seatly/ui/model/desk_details_model.dart';
import 'package:seatly/ui/providers/service_providers.dart';
import 'package:seatly/ui/viewmodel/classroom/classroom_addpage_viewmodel.dart';
import 'package:seatly/ui/viewmodel/classroom/classroom_detailpage_viewmodel.dart';
import 'package:seatly/ui/viewmodel/classroom/classroom_homepage_viewmodel.dart';
import 'package:seatly/ui/viewmodel/desk/desk_detailpage_viewmodel.dart';

final classroomHomepageViewModel = StateNotifierProvider<ClassroomHomepageViewModel, AsyncValue<List<Classroom>>>((ref) {
  final classroomService = ref.read(classroomServiceProvider);
  return ClassroomHomepageViewModel(classroomService)..loadClassrooms();
});

final classroomAddPageViewModel = StateNotifierProvider<ClassroomAddPageViewModel, ClassroomAddModel>((ref) {
  final classroomService = ref.read(classroomServiceProvider);
  return ClassroomAddPageViewModel(classroomService);
});

final classroomDetailPageViewModel = StateNotifierProvider.family<ClassroomDetailPageViewModel, AsyncValue<ClassroomDetailsModel>, String>((ref, classroomId) {
  final classroomService = ref.read(classroomServiceProvider);
  final studentService = ref.read(studentServiceProvider);
  return ClassroomDetailPageViewModel(classroomService, studentService)..loadClassroomDetails(classroomId);
});

final deskDetailPageViewModel = StateNotifierProvider.family<DeskDetailPageViewModel, AsyncValue<DeskDetailsModel>, String>((ref, studentId) {
  final studentService = ref.read(studentServiceProvider);
  return DeskDetailPageViewModel(studentService)..fetchStudentDetails(studentId);
});