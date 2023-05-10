import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

class Increment extends CounterEvent {
  @override
  List<Object?> get props => [];
}

class Decrement extends CounterEvent {
  @override
  List<Object?> get props => [];
}
