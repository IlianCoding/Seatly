import 'package:get_it/get_it.dart';

import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/repository/student/student_repository.dart';
import 'package:seatly/repository/classroom/i_classroom_repository.dart';
import 'package:seatly/repository/classroom/classroom_repository.dart';

import 'utils/json_write_read.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Register JsonWriteRead
  getIt.registerLazySingleton(() => JsonWriteRead());

  // Register ClassroomRepository with injected JsonWriteRead
  getIt.registerLazySingleton<IClassroomRepository>(
        () => ClassroomRepository(jsonWriteRead: getIt<JsonWriteRead>()),
  );
  getIt.registerLazySingleton<IStudentRepository>(
        () => StudentRepository(jsonWriteRead: getIt<JsonWriteRead>()),
  );
}