import 'dart:convert';

import 'package:bloc_state/models/login.dart';
import 'package:http/http.dart';

import '../the_response.dart';

class AuthRepository {
  String endpoint = 'https://jsonplaceholder.typicode.com/users';

  Future<TheResponse<Login>> signIn(Map data) async {
    Response response = await get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: Login.fromJson(jsonDecode(response.body)),
      );
    }

    return TheResponse(
      code: 0,
      message: 'Failed',
      data: Login.fromJson(jsonDecode(response.body)),
    );
  }

  Future<TheResponse<Login>> signUp(Map data) async {
    Response response = await post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: Login.fromJson(jsonDecode(response.body)),
      );
    }

    return TheResponse(
      code: 0,
      message: 'Failed',
      data: Login.fromJson(jsonDecode(response.body)),
    );
  }

  Future<TheResponse<Login>> signOut() async {
    Response response = await get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: Login.fromJson(jsonDecode(response.body)),
      );
    }

    return TheResponse(
      code: 0,
      message: 'Failed',
      data: Login.fromJson(jsonDecode(response.body)),
    );
  }

  Future<TheResponse<Login>> resetPassword(Map data) async {
    Response response = await post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: Login.fromJson(jsonDecode(response.body)),
      );
    }

    return TheResponse(
      code: 0,
      message: 'Failed',
      data: Login.fromJson(jsonDecode(response.body)),
    );
  }

  Future<TheResponse<Login>> updatePassword(Map data) async {
    Response response = await post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: Login.fromJson(jsonDecode(response.body)),
      );
    }

    return TheResponse(
      code: 0,
      message: 'Failed',
      data: Login.fromJson(jsonDecode(response.body)),
    );
  }

  Future<TheResponse<Login>> changeProfile(Map data) async {
    Response response = await post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: Login.fromJson(jsonDecode(response.body)),
      );
    }

    return TheResponse(
      code: 0,
      message: 'Failed',
      data: Login.fromJson(jsonDecode(response.body)),
    );
  }

  Future<bool> isSignedIn() async {
    return true;
  }
}
