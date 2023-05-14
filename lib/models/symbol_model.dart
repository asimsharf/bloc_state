class SymbolModel {
  final String symbol;
  final String price;

  SymbolModel({required this.symbol, required this.price});

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(
      symbol: json['symbol'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'SymbolModel{symbol: $symbol, price: $price}';
  }
}
