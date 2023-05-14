import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/user.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class Fetch extends UserEvent {
  @override
  List<Object?> get props => [];
}

class FetchGetCandleData extends UserEvent {
  @override
  List<Object?> get props => [];
}

class Update extends UserEvent {
  final UserModel user;

  const Update({required this.user});

  @override
  List<Object?> get props => [user];
}

class Delete extends UserEvent {
  final UserModel user;

  const Delete({required this.user});

  @override
  List<Object?> get props => [user];
}

class Create extends UserEvent {
  final UserModel user;

  const Create({required this.user});

  @override
  List<Object?> get props => [user];
}

class Clear extends UserEvent {
  @override
  List<Object?> get props => [];
}

class Search extends UserEvent {
  final String keyword;

  const Search({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}

class Sort extends UserEvent {
  final String field;
  final bool ascending;

  const Sort({required this.field, required this.ascending});

  @override
  List<Object?> get props => [field, ascending];
}

class Filter extends UserEvent {
  final String field;
  final String value;

  const Filter({required this.field, required this.value});

  @override
  List<Object?> get props => [field, value];
}

class FilterRange extends UserEvent {
  final String field;
  final String from;
  final String to;

  const FilterRange(
      {required this.field, required this.from, required this.to});

  @override
  List<Object?> get props => [field, from, to];
}

class FilterDate extends UserEvent {
  final String field;
  final String date;

  const FilterDate({required this.field, required this.date});

  @override
  List<Object?> get props => [field, date];
}
