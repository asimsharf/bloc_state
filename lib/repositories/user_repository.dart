import 'dart:convert';

import 'package:bloc_state/models/candle_model.dart';
import 'package:bloc_state/models/symbol_model.dart';
import 'package:bloc_state/models/user.dart';
import 'package:http/http.dart';

import '../utils/the_response.dart';

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

  // get24hrData
  // https://api.binance.com/api/v3/klines?symbol=BNBUSDT&interval=1s&limit=500
  final String endpointPath24Hour = "/api/v3/ticker/24hr";
  Future<TheResponse<List<dynamic>>> get24hrData() async {
    Response response = await get(
      Uri.parse(endpointPath24Hour),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: (jsonDecode(response.body) as List).map((e) {
          return e;
        }).toList(),
      );
    }
    return TheResponse(
      code: 0,
      message: 'Failed',
      data: [],
    );
  }

  //getCandleData
  final String endpointPathCandle =
      "https://api.binance.com/api/v3/klines?symbol=BNBUSDT&interval=1s&limit=500";
  // {required String symbol, required String interval}
  Stream<List<CandleModel>> getCandleData() async* {
    Response response = await get(
      Uri.parse(endpointPathCandle),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      yield (jsonDecode(response.body) as List).map((e) {
        return CandleModel(
          x: DateTime.fromMillisecondsSinceEpoch(e[0]),
          open: num.parse(e[1]),
          high: num.parse(e[2]),
          low: num.parse(e[3]),
          close: num.parse(e[4]),
        );
      }).toList();
    }
  }

  //getSymbolData
  final String endpointPathSymbol = "/api/v3/ticker/price?";
  // {required String symbol}
  Future<TheResponse<List<SymbolModel>>> getSymbolData() async {
    Response response = await get(
      Uri.parse(endpointPathSymbol),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return TheResponse(
        code: 1,
        message: 'Success',
        data: (jsonDecode(response.body) as List).map((e) {
          return SymbolModel.fromJson(e);
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
