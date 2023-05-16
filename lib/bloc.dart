import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

/// Models
class UserModel {
  int id;
  String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name']);
  }
}

/// WebServices
class UserWebServices {
  Future<List<UserModel>> fetchUsers() async {
    const String endpoint = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception("Unable to fetch users data ");
    }
  }
}

/// Repositories
class UserRepository {
  final UserWebServices userWebServices = UserWebServices();

  Future<List<UserModel>> fetchUser() async {
    return await userWebServices.fetchUsers();
  }
}

/// Stats
@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class Loading extends UserState {
  @override
  List<Object?> get props => [];
}

class Loaded extends UserState {
  final List<UserModel> users;

  const Loaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class Error extends UserState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Events
@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class Fetch extends UserEvent {
  @override
  List<Object?> get props => [];
}

/// Cubits
class UserCubit extends Cubit<UserState> {
  UserRepository userRepository = UserRepository();

  UserCubit({required this.userRepository}) : super(Loading()) {
    fetchUsers();
  }

  void fetchUsers() {
    userRepository.fetchUser().then((user) {
      emit(Loaded(users: user));
    }).catchError((onError) {
      emit(Error(message: onError.toString()));
    });
  }
}

/// Blocs

/// UI
