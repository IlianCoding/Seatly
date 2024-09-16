import 'package:get_it/get_it.dart';

import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/repository/student/student_repository.dart';
import 'package:seatly/repository/classroom/i_classroom_repository.dart';
import 'package:seatly/repository/classroom/classroom_repository.dart';
import 'package:seatly/service/classroom/classroom_service.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/service/student/i_student_service.dart';
import 'package:seatly/service/student/student_service.dart';

import 'utils/json_write_read.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Register JsonWriteRead
  getIt.registerLazySingleton(() => JsonWriteRead());

  // Register Repositories
  getIt.registerLazySingleton<IClassroomRepository>(
        () => ClassroomRepository(jsonWriteRead: getIt<JsonWriteRead>()),
  );
  getIt.registerLazySingleton<IStudentRepository>(
        () => StudentRepository(jsonWriteRead: getIt<JsonWriteRead>()),
  );

  // Register Services
  getIt.registerLazySingleton<IClassroomService>(
        () => ClassroomService(
            classroomRepository: getIt<IClassroomRepository>(),
            studentRepository: getIt<IStudentRepository>()
        )
  );
  getIt.registerLazySingleton<IStudentService>(
        () => StudentService(
            studentRepository: getIt<IStudentRepository>()
        )
  );
}