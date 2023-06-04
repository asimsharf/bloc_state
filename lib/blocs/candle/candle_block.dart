import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_state/blocs/candle/candle_event.dart';
import 'package:bloc_state/blocs/candle/candle_state.dart';
import 'package:bloc_state/models/candle_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/candle_repository.dart';

class CandleBloc extends Bloc<CandleEvent, CandleState> {
  final CandleRepository candleRepository;

  CandleBloc({required this.candleRepository}) : super(Empty()) {
    timer();
    on<CandleEvent>((event, emit) {
      if (event is Fetch) {
        // emit(Loading());
        fetch(event, emit);
      }
    });
  }

  timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      add(Fetch());
    });
  }

  fetch(event, emit) async {
    try {
      Stream<List<CandleModel>> candles = candleRepository.getCandle();

      List<CandleModel> candleList = await candles.first;
      emit(Loaded(candles: candleList));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
