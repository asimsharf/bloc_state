import 'package:bloc_state/blocs/users/user_states.dart';
import 'package:bloc_state/repositories/user_repository.dart';
import 'package:bloc_state/screens/counter.dart';
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
      )..add(Fetch()),
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const Counter()),
              );
            },
            child: const Text('Bloc Counter State'),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is Error) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is Empty) {
              return const Center(
                child: Text('No data'),
              );
            }
            return ListView.builder(
              itemCount: (state as Loaded).users.length,
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
