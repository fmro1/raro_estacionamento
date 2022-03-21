
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/models/spot_history.dart';


class SpotController extends ChangeNotifier {
  SpotController(){
    _listenToSpots();
    _listenToHistory();
  }

  final FirebaseDatabaseController firebaseController = locator<FirebaseDatabaseController>();

  late StreamSubscription _spotsStream;
  late StreamSubscription _historyStream;

  List<Spot> _spots = [];
  List<SpotHistory> _history = [];

  List<SpotHistory> get history => _history;
  List<Spot> get spots => _spots;

  vehicleIn({required Spot spot}) {
    /*create history obj*/
    SpotHistory history = SpotHistory(
        spotId: spot.id,
        plate: spot.plate,
        inDateTime: DateTime.now()
    );
    firebaseController.addVehicleInSpot(
        spot: spot,
        history: history);
  }


  vehicleOut({required Spot spot}) {
    /*create history obj*/
    SpotHistory history = SpotHistory(
        spotId: spot.id,
        plate: spot.plate,
        inDateTime: DateTime.now()
    );
    firebaseController.removeVehicleFromSpot(spot: spot, history: history);
  }

  bool isSpotInUse({required int spot}){
    return false;
  }

  void _listenToSpots() {
    _spotsStream = firebaseController.getSpotsReference().listen((event) {
      final spotMap = event.snapshot.children.map((e) => e.value as Map).toList();
      _spots = spotMap.map((e) {
        /*converting to object Spot()*/
        return Spot.fromRTDB(Map<String, dynamic>.from(e));
      }).toList();
      notifyListeners();
    });
  }

  void _listenToHistory() {
    _historyStream = firebaseController.getHistoryReference().listen((event) {
      final historyMap = event.snapshot.children.map((e) => e.value as Map)
          .toList();
      //print(historyMap);
      _history = historyMap.map((element) {
        print('element: $element');
        /*converte para SpotHistory()*/
        return SpotHistory.fromRTDB(Map<String, dynamic>.from(element));
      }).toList();
      notifyListeners();
      });
  }

  @override
  void dispose() {
    _spotsStream.cancel();
    _historyStream.cancel();
    super.dispose();
  }


}
