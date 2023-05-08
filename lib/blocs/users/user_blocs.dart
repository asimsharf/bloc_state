import 'package:bloc_state/blocs/users/user_states.dart';
import 'package:bloc_state/the_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import 'user_events.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserEmptyState()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUserEvent) {
        emit(UserLoadingState());
        try {
          TheResponse response = await userRepository.getUsers();
          if (response.code == 1) {
            emit(UserLoadedState(users: response.data));
          } else {
            emit(UserErrorState(message: response.message));
          }
        } catch (e) {
          emit(UserErrorState(message: e.toString()));
        }
      }
    });
  }
}
