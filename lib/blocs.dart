import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// [BLL],
/// BLL -> Business Logic Layer
/// [DAL],
/// DAL -> Database Access Layer
/// [PL]
/// PL -> Presentation Layer

/// DAL -> Database Access Layer ->
/// lib/entities
// EmployeeModel
class EmployeeModel {
  int id;
  String name;
  EmployeeModel({required this.id, required this.name});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(id: json['id'], name: json['name']);
  }
}

/// lib/services
// EmployeeWebServices
class EmployeeWebServices {
  Future<List<EmployeeModel>> fetchEmployees() async {
    final response = await http.get(Uri.parse('api/employees'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((employee) => EmployeeModel.fromJson(employee))
          .toList();
    } else {
      throw Exception("Unable to fetch employees!");
    }
  }
}

/// lib/repositories
// EmployeeRepository
class EmployeeRepository {
  final EmployeeWebServices _employeeWebServices = EmployeeWebServices();

  Future<List<EmployeeModel>> fetchEmployee() async {
    return _employeeWebServices.fetchEmployees();
  }
}

/// BLL -> Business Logic Layer ->
/// lib/
// EmployeeStates
@immutable
abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

// EmployeeStates -> Empty
class Empty extends EmployeeState {
  @override
  List<Object> get props => [];
}

// EmployeeStates -> Loading
class Loading extends EmployeeState {
  @override
  List<Object?> get props => [];
}

// EmployeeStates -> Loaded
class Loaded extends EmployeeState {
  final List<EmployeeModel> employees;
  const Loaded({required this.employees});

  @override
  List<Object?> get props => [employees];
}

// EmployeeStates -> Error
class Error extends EmployeeState {
  final String message;
  const Error({required this.message});
  @override
  List<Object> get props => [message];
}

// EmployeeEvents
// EmployeeEvents -> Fetch
// EmployeeEvents -> Create
// EmployeeEvents -> Delete
// EmployeeEvents -> Update
// EmployeeEvents -> Search
// EmployeeEvents -> Filter
// EmployeeEvents -> Sort

// EmployeeBlocs

/// PL -> Presentation Layer ->
/// lib/views
// EmployeeViews
