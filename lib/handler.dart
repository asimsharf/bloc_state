import 'dart:convert';

import 'package:equatable/equatable.dart';
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
        'https://jsonplaceholder.typicode.com/users',
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
abstract class StudentEvent extends Equatable {
  const StudentEvent();
}

class FetchStudents extends StudentEvent {
  const FetchStudents();

  @override
  List<Object?> get props => [];
}

/// State
@immutable
abstract class StudentState extends Equatable {
  const StudentState();
}

class StudentLoading extends StudentState {
  const StudentLoading();

  @override
  List<Object?> get props => [];
}

class StudentLoaded extends StudentState {
  final List<Student> students;
  const StudentLoaded({required this.students});

  @override
  List<Object?> get props => [students];
}

class StudentError extends StudentState {
  final String message;
  const StudentError({required this.message});

  @override
  List<Object?> get props => [message];
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

/// Presentation Layer

/// Student View
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
              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () {
                    // StudentDetailPage.route(state.students[index]);

                    StudentDetailPage.route(state.students[index], context);
                  },
                  title: Text(state.students[index].name),
                  subtitle: Text(state.students[index].id.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
                ),
              );
            },
          );
        } else if (state is StudentError) {
          return Card(
            child: ListTile(
                title: Text(state.message),
                subtitle: const Text('Something went wrong!')),
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

/// Student Detail Page
class StudentDetailPage extends StatelessWidget {
  final Student student;
  const StudentDetailPage({super.key, required this.student});

  static route(Student student, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailPage(student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(student.name),
            Text(student.id.toString()),
          ],
        ),
      ),
    );
  }
}

/// Main
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student List'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => StudentCubit(
                studentRepos: StudentRepository(),
              ),
            ),
          ],
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
