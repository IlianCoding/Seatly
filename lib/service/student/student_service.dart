import 'package:injectable/injectable.dart';
import 'package:seatly/domain/student.dart';
import 'package:seatly/repository/student/i_student_repository.dart';
import 'package:seatly/service/student/i_student_service.dart';

@Singleton(as: IStudentService)
class StudentService implements IStudentService {
  final IStudentRepository studentRepository;

  StudentService({required this.studentRepository});

  @override
  Future<Student?> getStudentById(String id) {
    return studentRepository.readStudent(id);
  }

  @override
  Future<List<Student>> getAllStudents() {
    return studentRepository.readAllStudents();
  }

  @override
  Future<void> addStudent(Student student) {
    return studentRepository.createStudent(student);
  }

  @override
  Future<void> changeStudent(Student student) {
    return studentRepository.updateStudent(student);
  }

  @override
  Future<void> removeStudent(String id) {
    return studentRepository.deleteStudent(id);
  }
}