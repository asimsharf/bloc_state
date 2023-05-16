import 'package:bloc_state/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fetchStudents', () async {
    UserRepository studentRepository = UserRepository();
    List<UserModel> students = await studentRepository.fetchUser();
    for (var student in students) {
      print("Student: ${student.id} - ${student.name} ");
    }
    expect(students, isNotEmpty);
  });
}
