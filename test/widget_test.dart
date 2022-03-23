import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/locator.dart';

import 'package:raro_estacionamento/main.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/models/spot_history.dart';
import 'package:raro_estacionamento/views/common/main_big_button.dart';
import 'package:raro_estacionamento/views/history_today/components/history_card.dart';
import 'package:raro_estacionamento/views/my_spots/components/spot_card.dart';
import 'package:raro_estacionamento/views/my_spots/my_spots.dart';

import 'client/client_test.dart';

void main() {
  setUpAll(() async {
    setup(testing: true, setTest: (){
      locator.registerLazySingleton<FirebaseDatabaseController>(() =>
          MockFirebaseDatabaseController());
      locator.registerLazySingleton<SpotController>(() =>
          SpotController(
            isTesting: true,
            firebaseDatabaseController: MockFirebaseDatabaseController(),
          ));
    });

  });
  testWidgets('Main Page', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<SpotController>(
          create: (_) => locator<SpotController>(),
          child: MyApp(),
        )));

    await tester.pumpWidget(MaterialApp(
      home: MainBigButton(
        backgroundColor: Colors.green,
        text: "Entrada",
        iconData: Icons.arrow_forward_ios,
        textColor: Colors.white,
        onTap: (){},
      ),
    ));
  });

  testWidgets('spot card', (WidgetTester tester) async {
    Spot fakeSpot = Spot(id: 1,inDateTime: DateTime(2020), outDateTime: DateTime.now(), plate: "ASPÒ" );
    await tester.pumpWidget(
      MaterialApp(
        home: SpotCard(spot: fakeSpot),
      ),
    );
  });

  testWidgets('hisotry card', (WidgetTester tester) async {
    SpotHistory fakeHistory = SpotHistory(spotId: 4);
    await tester.pumpWidget(
      MaterialApp(
        home: HistoryCard(historySpot: fakeHistory),
      ),
    );
    expect(find.text("Vaga ${fakeHistory.spotId} - "), findsOneWidget);
  });
  testWidgets('hisotry card empty', (WidgetTester tester) async {
    SpotHistory fakeHistory = SpotHistory();
    await tester.pumpWidget(
      MaterialApp(
        home: HistoryCard(historySpot: fakeHistory),
      ),
    );
    expect(find.text("Vaga ${fakeHistory.spotId} - "), findsOneWidget);
  });
}
