
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/helpers/date_converter.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/models/spot.dart';


class MockFirebaseDatabaseController extends Mock implements FirebaseDatabaseController {}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {
  final controller = StreamController();
  @override
  Stream getSpotsReference() {
    return controller.stream;
  }

  @override
  Stream getHistoryReference() {
    return controller.stream;
  }
}

class MockSpotController extends Mock implements SpotController {
  @override
  List<Spot> get spots => [Spot(id: 1,), Spot(id: 2)];
}

void main() {
  setUpAll(() async {
    setup(testing: true, setTest: (){
      locator.registerLazySingleton<FirebaseDatabaseController>(() =>
          FirebaseDatabaseController(MockFirebaseDatabase()));
      locator.registerLazySingleton<SpotController>(() =>
          SpotController(
              firebaseDatabaseController: MockFirebaseDatabaseController(),
          ));
    });
  });
  group("my data converter", (){
    test("date and time of day to datetime", (){
      final date = DateTime.now();
      final time = TimeOfDay.now();
      DateConverter.convertValuesToDatetime(date, time);
    });
    test("fake spot success", (){
      Map spotFake = {'id': 1, 'inDateTime': 1160000, 'plate': 'fakePlate'};
      final res = Spot.fromRTDB(Map<String, dynamic>.from(spotFake));
      expect(res, isA<Spot>());
    });
    test("fake spot error", (){
      Map spotFake = {'id': 1.0, 'inDateTime': '1160000', 'plate': 111111};
      final res = Spot.fromRTDB(Map<String, dynamic>.from(spotFake));
      expect(res, isA<Spot>());
    });

  });

  test('adição de veiculo', () async {
    final inDate = DateTime.now();
    final inTime = TimeOfDay.now();
    await locator<SpotController>().vehicleIn(
        spotId: 1,
        inDate: inDate,
        inTime: inTime,
        plate: "123abc1");
  });

  test('remoção de veiculo', () async {
    final inDate = DateTime.now();
    final inTime = TimeOfDay.now();
    await locator<SpotController>().vehicleOut(
        spotId: 1,
        inDate: inDate,
        outTime: inTime,
        outDate: inDate,
        plate: "123abc1");
  });
}