import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/views/common/app_bar_background.dart';
import 'package:raro_estacionamento/views/history_today/components/history_card.dart';

class HistoryTodayView extends StatefulWidget {
  const HistoryTodayView({Key? key}) : super(key: key);

  @override
  State<HistoryTodayView> createState() => _HistoryTodayViewState();
}

class _HistoryTodayViewState extends State<HistoryTodayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico Hoje',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        flexibleSpace: MyAppBarBackground(),
      ),
      body: Consumer<SpotController>(builder: (_, spotController, __) {
        return Column(
          children: [
            if(spotController.historyToday.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Nenhuma movimentação hoje'),
              ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: spotController.historyToday.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      HistoryCard(historySpot: spotController.historyToday[index]),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                gradient: LinearGradient(
                  colors: [Colors.indigoAccent, Colors.cyan ,Colors.indigoAccent]
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("TOTAL:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: kTextSize),),
                  Row(children: [
                    Text("Entradas: ${context.read<SpotController>().countTodayIn()}",
                      style: TextStyle(color: Colors.white, fontSize: kTextSize),
                    ),
                    Spacer(),
                    Text("Saídas: ${context.read<SpotController>().countTodayOut()}",
                      style: TextStyle(color: Colors.white, fontSize: kTextSize),
                    )
                  ],),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
