import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/views/common/app_bar_background.dart';
import 'package:raro_estacionamento/views/history_today/components/history_today_card.dart';

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
      body: ListView(
        shrinkWrap: true,
        children: [
          Consumer<SpotController>(builder: (_, spotController, __) {
            return Column(
              children: [
                if(spotController.historyToday.isEmpty)
                  Text('Nenhuma movimentação hoje'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: spotController.historyToday.length,
                  itemBuilder: (context, index) {
                    return HistoryTodayCard(historySpot: spotController.historyToday[index]);
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
