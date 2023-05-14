import 'dart:convert';

import 'package:bloc_state/models/candle_model.dart';
import 'package:http/http.dart';

class CandleRepository {
  String endpoint =
      'https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1s&limit=500';
  Stream<List<CandleModel>> getCandle() async* {
    Response response = await get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      yield (jsonDecode(response.body) as List).map((e) {
        return CandleModel(
          x: DateTime.fromMillisecondsSinceEpoch(e[0]),
          high: num.parse(e[2]),
          low: num.parse(e[3]),
          close: num.parse(e[4]),
          open: num.parse(e[1]),
        );
      }).toList();
    }

    yield [];
  }
}
