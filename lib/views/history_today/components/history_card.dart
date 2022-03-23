import 'package:flutter/material.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/helpers/date_converter.dart';
import 'package:raro_estacionamento/models/spot_history.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key,
    required this.historySpot,
  }) : super(key: key);

  final SpotHistory historySpot;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.symmetric(vertical: kVPadding, horizontal: kHPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Flexible(child: Text("Vaga ${historySpot.spotId} - ", style: defaultStyle,)),
            Expanded(child: Text("Placa ${historySpot.plate}", style: defaultStyle))
          ],),
          Text("Entrada: "+((){
            if(historySpot.inDateTime != null && historySpot.inDateTime is DateTime)
              return DateConverter.dateToString(historySpot.inDateTime!, format: "dd/MM/yy HH:mm");
            else return "-";
          }()),
            style: defaultStyle,
          ),
          Text("Saída: "+((){
            if(historySpot.outDateTime != null && historySpot.outDateTime is DateTime)
              return DateConverter.dateToString(historySpot.outDateTime!, format: "dd/MM/yy HH:mm");
            else return "-";
          }()),
          style: defaultStyle,
          ),
        ],
      ),
    );
  }
}
