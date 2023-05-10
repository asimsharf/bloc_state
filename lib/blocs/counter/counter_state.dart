import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CounterState extends Equatable {
  const CounterState();
  int get count => 0;
}

class Count extends CounterState {
  @override
  final int count;

  const Count({required this.count});

  @override
  List<Object?> get props => [count];
}
