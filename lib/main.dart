import 'package:bloc_state/blocs/user_states.dart';
import 'package:bloc_state/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/user_blocs.dart';
import 'blocs/user_events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc State',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

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
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {},
                  title: Text(state.users[i].name),
                  subtitle: Text(state.users[i].email),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
