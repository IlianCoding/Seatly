import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/repository/student/student_repository.dart';

import 'student_repository_test.mocks.dart';

@GenerateMocks([JsonWriteRead])
void main() {
  group('StudentRepository - all functions.', (){
    late StudentRepository studentRepository;
    late MockJsonWriteRead mockJsonWriteRead;

    setUp((){
      mockJsonWriteRead = MockJsonWriteRead();
      studentRepository = StudentRepository(jsonWriteRead: mockJsonWriteRead);
    });
  });
}