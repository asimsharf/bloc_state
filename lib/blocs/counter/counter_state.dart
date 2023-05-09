import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class CounterState extends Equatable {
  final int count;

  const CounterState({required this.count});

  @override
  List<Object?> get props => [count];
}
