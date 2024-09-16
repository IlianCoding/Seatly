import 'package:injectable/injectable.dart';
import 'package:seatly/model/student.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/service/student/i_student_service.dart';

@Singleton(as: IStudentService)
class StudentService implements IStudentService {
  final IStudentRepository studentRepository;

  StudentService({required this.studentRepository});

  @override
  Future<Student?> getStudentById(int id) {
    // TODO: implement getStudentById
    throw UnimplementedError();
  }

  @override
  Future<List<Student>> getAllStudents() {
    // TODO: implement getAllStudents
    throw UnimplementedError();
  }

  @override
  Future<void> createStudent(Student student) {
    // TODO: implement createStudent
    throw UnimplementedError();
  }

  @override
  Future<void> changeStudent(Student student) {
    // TODO: implement changeStudent
    throw UnimplementedError();
  }

  @override
  Future<void> removeStudent(int id) {
    // TODO: implement removeStudent
    throw UnimplementedError();
  }
}