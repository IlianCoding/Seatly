import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/service/student/i_student_service.dart';

final classroomServiceProvider = Provider<IClassroomService>((ref) {
  return GetIt.I<IClassroomService>();
});

final studentServiceProvider = Provider<IStudentService>((ref) {
  return GetIt.I<IStudentService>();
});