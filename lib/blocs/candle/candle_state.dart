import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/candle_model.dart';

@immutable
abstract class CandleState extends Equatable {
  const CandleState();
}

class Empty extends CandleState {
  @override
  List<Object?> get props => [];
}

class Loading extends CandleState {
  @override
  List<Object?> get props => [];
}

class Loaded extends CandleState {
  final List<CandleModel> candles;

  const Loaded({required this.candles});

  @override
  List<Object?> get props => [candles];
}

class Error extends CandleState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}
