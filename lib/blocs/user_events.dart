import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final UserModel user;

  const UpdateUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class DeleteUserEvent extends UserEvent {
  final UserModel user;

  const DeleteUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class CreateUserEvent extends UserEvent {
  final UserModel user;

  const CreateUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}
