import 'package:flutter/material.dart';
import 'package:raro_estacionamento/models/spot_history.dart';

class HistoryTodayCard extends StatelessWidget {
  const HistoryTodayCard({Key? key,
    required this.historySpot,
  }) : super(key: key);

  final SpotHistory historySpot;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${historySpot.spotId}"),
    );
  }
}
