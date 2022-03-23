
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/helpers/date_converter.dart';
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
  List<SpotHistory> _historyToday = [];
  Spot? newSpotVehicle;

  List<SpotHistory> get historyToday => _historyToday;
  List<Spot> get spots => _spots;

  Future<void> vehicleIn({
    required int spotId,
    required DateTime inDate,
    required TimeOfDay inTime,
    required String plate,}) async {
    DateTime newDate = DateTime(inDate.year, inDate.month, inDate.day, inTime.hour, inTime.minute);
    Spot newSpot = Spot(
      id: spotId,
      inDateTime: newDate,
      plate: plate,
    );

    /*create history obj*/
    SpotHistory history = SpotHistory(
        spotId: newSpot.id,
        plate: newSpot.plate,
        inDateTime: newDate
    );
    firebaseController.addVehicleInSpot(
        spot: newSpot,
        history: history);
  }


  Future<void> vehicleOut({required int spotId,
    required DateTime inDate,
    required DateTime outDate,
    required TimeOfDay outTime,
    required String plate,}) async {
    DateTime newInDate = DateTime(inDate.year, inDate.month, inDate.day, inDate.hour, inDate.minute);
    DateTime newOutDate = DateTime(outDate.year, outDate.month, outDate.day, outTime.hour, outTime.minute);

    Spot newSpot = Spot(
      id: spotId,
      inDateTime: newInDate,
      outDateTime: newOutDate,
      plate: plate,
    );
    /*create history obj*/
    SpotHistory history = SpotHistory(
        spotId: newSpot.id,
        plate: newSpot.plate,
        inDateTime: newInDate,
      outDateTime: newOutDate,
    );

    firebaseController.removeVehicleFromSpot(spot: newSpot, history: history);
  }

  bool isSpotInUse({required Spot spot}){
    return spot.plate != null;
  }

  int countTodayIn(){
    int countIn = 0;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _historyToday.forEach((element) {
      if(element.inDateTime != null && element.inDateTime is DateTime){
        DateTime elementDate = DateTime(
            element.inDateTime!.year,
            element.inDateTime!.month,
            element.inDateTime!.day);
        if(elementDate.isAtSameMomentAs(today)){
          countIn++;
        }
      }
    });
    return countIn;
  }
  int countTodayOut(){
    int countOut = 0;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _historyToday.forEach((element) {
      if(element.outDateTime != null && element.outDateTime is DateTime){
        DateTime elementDate = DateTime(
            element.outDateTime!.year,
            element.outDateTime!.month,
            element.outDateTime!.day);
        if(elementDate.isAtSameMomentAs(today)){
          countOut++;
        }
      }
    });
    return countOut;
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
      _historyToday = historyMap.map((element) {
        print('element: $element');
        /*converte para SpotHistory()*/
        return SpotHistory.fromRTDB(Map<String, dynamic>.from(element));
      }).toList();
      notifyListeners();
      });
  }


  List<SpotHistory> _allHistory = [];
  set allHistory(List<SpotHistory> value) {
    _allHistory = value;
  }
  List<SpotHistory> get allHistory => _allHistory;

  Future<void> getAllHistory() async {
    final data = await firebaseController.getHistoryCustomReference();
    final daysMap = data.snapshot.children.map((e) => e.value as Map)
        .toList();
    final _allHistoryDays = daysMap.map((e) => e).toList();
    //print(historyMap);
    _allHistoryDays.forEach((element) {
      /*converte para SpotHistory()*/
      List mapList = element.entries.map((e) => e.value).toList();
      _allHistory.addAll(mapList.map((e) {
        print('element: $e');
        return SpotHistory.fromRTDB(Map<String, dynamic>.from(e as Map));
      }).toList());
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
