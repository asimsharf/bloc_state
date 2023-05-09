import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

class IncrementCounterEvent extends CounterEvent {
  @override
  List<Object?> get props => [];
}

class DecrementCounterEvent extends CounterEvent {
  @override
  List<Object?> get props => [];
}
