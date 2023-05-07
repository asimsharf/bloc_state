import 'dart:convert';

import 'package:bloc_state/models/user.dart';
import 'package:http/http.dart';

import '../the_response.dart';

class UserRepository {
  String endpoint = 'https://jsonplaceholder.typicode.com/users';
  Future<TheResponse<List<UserModel>>> getUsers() async {
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
        data: (jsonDecode(response.body) as List).map((e) {
          return UserModel.fromJson(e);
        }).toList(),
      );
    }
    return TheResponse(
      code: 0,
      message: 'Failed',
      data: [],
    );
  }
}
