import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/user.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class Empty extends UserState {
  @override
  List<Object?> get props => [];
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
