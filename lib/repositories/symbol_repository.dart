import 'dart:convert';

import 'package:bloc_state/models/symbol_model.dart';
import 'package:http/http.dart';

const String base = 'https://api.binance.com/api/v3';

class SymbolRepository {
  String endpoint = '$base/ticker/ticker/price?symbol=BNBUSDT';
  Stream<List<SymbolModel>> getSymbol() async* {
    Response response = await get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      yield (jsonDecode(response.body) as List).map((e) {
        return SymbolModel(
          symbol: e['symbol'],
          price: e['price'],
        );
      }).toList();
    }

    yield [];
  }
}
