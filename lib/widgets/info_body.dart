import 'package:flutter/material.dart';

import '../models/candle_model.dart';

class InfoBody extends StatelessWidget {
  const InfoBody({super.key, required this.candle});

  final List<CandleModel> candle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _informations("Opening Price", candle.last.open.toString()),
          _informations("Close Price", candle.last.close.toString()),
          _informations("High Price", candle.last.high.toString()),
          _informations("Low Price", candle.last.low.toString()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Column _informations(String title, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                "\$$value",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
