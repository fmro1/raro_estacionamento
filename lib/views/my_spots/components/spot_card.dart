import 'package:flutter/material.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/models/spot.dart';

class SpotCard extends StatelessWidget {
  const SpotCard({Key? key,
  required this.spot,
  }) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: Column(
        children: [
          Text('Vaga ${spot.id}'),
          Text(spot.plate ?? 'Livre'),
        ],
      ),

    );
  }
}
