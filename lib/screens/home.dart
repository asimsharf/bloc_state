import 'package:bloc_state/blocs/users/user_states.dart';
import 'package:bloc_state/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users/user_blocs.dart';
import '../blocs/users/user_events.dart';
import '../widgets/card_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc State'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is UserEmptyState) {
              return const Center(
                child: Text('No data'),
              );
            }
            return ListView.builder(
              itemCount: (state as UserLoadedState).users.length,
              itemBuilder: (_, i) {
                return cardList(_, user: state.users[i]);
              },
            );
          },
        ),
      ),
    );
  }
}
