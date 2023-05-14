import 'package:bloc_state/repositories/candle_repository.dart';
import 'package:bloc_state/repositories/user_repository.dart';
import 'package:bloc_state/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc State',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //CandleRepository()
      //UserRepository()
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => UserRepository()),
          RepositoryProvider(create: (_) => CandleRepository()),
        ],
        child: const Home(),
      ),
    );
  }
}
