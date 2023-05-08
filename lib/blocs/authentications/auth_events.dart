import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStartedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoggedInEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoggedOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class UpdatePasswordEvent extends AuthEvent {
  final String password;

  const UpdatePasswordEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class UpdateProfileEvent extends AuthEvent {
  final String name;
  final String phone;
  final String address;

  const UpdateProfileEvent(
      {required this.name, required this.phone, required this.address});

  @override
  List<Object?> get props => [name, phone, address];
}

class UpdateProfilePictureEvent extends AuthEvent {
  final String profilePicture;

  const UpdateProfilePictureEvent({required this.profilePicture});

  @override
  List<Object?> get props => [profilePicture];
}
