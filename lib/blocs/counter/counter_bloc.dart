import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const Count(count: 0)) {
    on<CounterEvent>((event, emit) {
      if (event is Increment) {
        emit(Count(count: state.count + 1));
      } else if (event is Decrement) {
        emit(Count(count: state.count - 1));
      }
    });
  }
}
