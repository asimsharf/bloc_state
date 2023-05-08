import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppStartedEvent) {
        emit(AuthLoadingState());
        try {
          bool isSignedIn = await authRepository.isSignedIn();
          if (isSignedIn) {
            emit(AuthenticatedState());
          } else {
            emit(UnAuthenticatedState());
          }
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      } else if (event is LoggedInEvent) {
        emit(AuthLoadingState());
        try {
          await authRepository.signIn({
            'email': 'email@email',
          });
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      } else if (event is LoggedOutEvent) {
        emit(AuthLoadingState());
        try {
          await authRepository.signOut();
          emit(UnAuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      } else if (event is RegisterEvent) {
        emit(AuthLoadingState());
        try {
          await authRepository.signUp({
            'email': event.email,
            'password': event.password,
            'name': event.email.split('@')[0],
          });
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      } else if (event is LoginEvent) {
        emit(AuthLoadingState());
        try {
          await authRepository.signIn({
            'email': event.email,
            'password': event.password,
          });
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      } else if (event is ResetPasswordEvent) {
        emit(AuthLoadingState());
        try {
          await authRepository.resetPassword({
            'email': event.email,
          });
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      } else if (event is UpdatePasswordEvent) {
        emit(AuthLoadingState());
        try {
          await authRepository.updatePassword({
            'password': event.password,
          });
          emit(AuthenticatedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      }
    });
  }
}
