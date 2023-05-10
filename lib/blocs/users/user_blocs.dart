import 'package:bloc_state/blocs/users/user_states.dart';
import 'package:bloc_state/utils/the_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import 'user_events.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(Empty()) {
    on<UserEvent>((event, emit) async {
      if (event is Fetch) {
        emit(Loading());
        try {
          TheResponse response = await userRepository.getUsers();
          if (response.code == 1) {
            emit(Loaded(users: response.data));
          } else {
            emit(Error(message: response.message));
          }
        } catch (e) {
          emit(Error(message: e.toString()));
        }
      }
    });
  }
}
