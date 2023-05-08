import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/user.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class UserEmptyState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserModel> users;

  const UserLoadedState({required this.users});

  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
