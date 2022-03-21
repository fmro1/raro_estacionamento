
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/models/spot_history.dart';


class MockFirebaseDatabaseController extends Mock implements FirebaseDatabaseController {}
class MockSpotController extends Mock implements SpotController {}

void main() {
  late SpotController spotController;
  final sl = GetIt.instance;
  setUp(() {
    sl.registerLazySingleton<FirebaseDatabaseController>(() => MockFirebaseDatabaseController());
    sl.registerLazySingleton<SpotController>(() => MockSpotController());
  });

  test('make request', () async {
    sl<SpotController>().vehicleIn(
        spot: Spot(id: 6, plate: "k3r44j3"),
    );
    sl<FirebaseDatabaseController>().removeVehicleFromSpot(
        spot: Spot(id: 6, plate: "asdasd", outDateTime: DateTime.now()),
      history: SpotHistory(spotId: 6, outDateTime: DateTime.now(),
        key: "-MygOZ5mxXRXAVtIIL7C",
      )
    );
  });

  test('add vehicle', () async {
    int spot = 1;
    //await spotController.vehicleIn(vehicle: Vehicle(), spot: spot);

  });
}