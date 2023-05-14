import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CandleEvent extends Equatable {
  const CandleEvent();
}

class Fetch extends CandleEvent {
  @override
  List<Object?> get props => [];
}
