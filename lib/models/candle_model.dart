class CandleModel {
  final DateTime? x;
  final num? high;
  final num? low;
  final num? open;
  final num? close;

  CandleModel({
    this.x,
    this.high,
    this.low,
    this.open,
    this.close,
  });

  factory CandleModel.fromJson(Map<String, dynamic> json) {
    return CandleModel(
      x: DateTime.fromMillisecondsSinceEpoch(json[0]),
      open: json[1],
      high: json[2],
      low: json[3],
      close: json[4],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'high': high,
      'low': low,
      'open': open,
      'close': close,
    };
  }

  @override
  String toString() {
    return 'Candle{x: $x, high: $high, low: $low, open: $open, close: $close}';
  }
}
