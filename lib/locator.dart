import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:raro_estacionamento/controllers/firebase_database_controller.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';

final locator = GetIt.instance;

FirebaseDatabase database = FirebaseDatabase.instance;

void setup({bool testing = false, Function()? setTest}) async {
  if(!testing){
    locator.registerLazySingleton<FirebaseDatabaseController>(() => FirebaseDatabaseController(database));
    locator.registerLazySingleton<SpotController>(() => SpotController());
  } else {
    if(setTest != null){
      setTest();
    }
  }
}