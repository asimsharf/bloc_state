import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(count: 0)) {
    on<IncrementCounterEvent>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });

    on<DecrementCounterEvent>((event, emit) {
      emit(CounterState(count: state.count - 1));
    });
  }
}
