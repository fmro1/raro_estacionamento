import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/views/common/app_bar_background.dart';
import 'package:raro_estacionamento/views/history_today/components/history_card.dart';

class AllHistoryView extends StatefulWidget {
  const AllHistoryView({Key? key}) : super(key: key);

  @override
  State<AllHistoryView> createState() => _AllHistoryViewState();
}

class _AllHistoryViewState extends State<AllHistoryView> {

  @override
  void initState() {
    context.read<SpotController>().getAllHistory();
    super.initState();
  }
  @override
  void dispose() {
    context.read<SpotController>().allHistory = [];
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico Geral',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        flexibleSpace: MyAppBarBackground(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SpotController>(
              builder: (context, spotController, child) {
                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: spotController.allHistory.length,
                    itemBuilder: (_, index){
                  return Column(
                    children: [
                      HistoryCard(historySpot: spotController.allHistory[index]),
                      Divider(),
                    ],
                  );
                });
              }
            ),
          ),
        ],
      ),
    );
  }
}
