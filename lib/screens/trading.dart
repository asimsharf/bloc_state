import 'package:bloc_state/repositories/candle_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/candle/candle_block.dart';
import '../blocs/candle/candle_event.dart';
import '../blocs/candle/candle_state.dart';
import '../widgets/info_body.dart';

class Trading extends StatelessWidget {
  const Trading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandleBloc(
        // candleRepository: RepositoryProvider.of<CandleRepository>(context),
        candleRepository: CandleRepository(),
      )..add(Fetch()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BTCUSDT'),
        ),
        body: BlocBuilder<CandleBloc, CandleState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is Error) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is Empty) {
              return const Center(
                child: Text('...'),
              );
            }
            return InfoBody(candle: (state as Loaded).candles);
          },
        ),
      ),
    );
  }
}
