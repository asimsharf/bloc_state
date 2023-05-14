import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

/// Model
class Student {
  int id;
  String name;
  Student({required this.id, required this.name});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(id: json['id'], name: json['name']);
  }
}

/// Web Service
class StudentWebService {
  Future<List<Student>> fetchStudents() async {
    final response = await http.get(
      Uri.parse(
        'http://localhost:3000/students',
      ),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }
}

/// Repository
class StudentRepository {
  final StudentWebService studentService = StudentWebService();
  Future<List<Student>> fetchStudents() async {
    return await studentService.fetchStudents();
  }
}

/// Event
@immutable
abstract class StudentEvent {
  const StudentEvent();
}

class FetchStudents extends StudentEvent {
  const FetchStudents();
}

/// State
@immutable
abstract class StudentState {
  const StudentState();
}

class StudentLoading extends StudentState {
  const StudentLoading();
}

class StudentLoaded extends StudentState {
  final List<Student> students;
  const StudentLoaded({required this.students});
}

class StudentError extends StudentState {
  final String message;
  const StudentError({required this.message});
}

/// Cubit
class StudentCubit extends Cubit<StudentState> {
  final StudentRepository studentRepos;
  StudentCubit({required this.studentRepos}) : super(const StudentLoading()) {
    fetchStudents();
  }
  void fetchStudents() {
    studentRepos.fetchStudents().then((students) {
      emit(StudentLoaded(students: students));
    }).catchError((e) {
      emit(StudentError(message: e.toString()));
    });
  }
}

/// Bloc
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepos;
  StudentBloc({required this.studentRepos}) : super(const StudentLoading()) {
    fetchStudents();
  }
  void fetchStudents() {
    on<StudentEvent>((event, emit) async {
      if (event is FetchStudents) {
        try {
          final students = await studentRepos.fetchStudents();
          emit(StudentLoaded(students: students));
        } catch (e) {
          emit(StudentError(message: e.toString()));
        }
      }
    });
  }
}

/// View
class StudentView extends StatelessWidget {
  final StudentCubit studentCubit;
  const StudentView({super.key, required this.studentCubit});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      bloc: studentCubit,
      builder: (context, state) {
        if (state is StudentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is StudentLoaded) {
          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.students[index].name),
              );
            },
          );
        } else if (state is StudentError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
      },
    );
  }
}

/// Main
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student List'),
        ),
        body: BlocProvider(
          create: (context) => StudentCubit(
            studentRepos: StudentRepository(),
          ),
          child: StudentView(
            studentCubit: StudentCubit(
              studentRepos: StudentRepository(),
            ),
          ),
        ),
      ),
    ),
  );
}
