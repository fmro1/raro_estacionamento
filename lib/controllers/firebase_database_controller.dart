

import 'package:firebase_database/firebase_database.dart';
import 'package:raro_estacionamento/helpers/date_converter.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/models/spot_history.dart';

class FirebaseDatabaseController {

  FirebaseDatabaseController(FirebaseDatabase database);

  DatabaseReference ref = database.ref();

  Future setInitialData() async {
    print('initial data');
    List<int> spotList = List.generate(100, (index) => index);
    await Future.forEach(spotList, (int element) async {
       await ref.child('spots')
          .child('${element+1}')
          .update({
        "id" : element+1,
        "inDateTime": null,
        "outDateTime": null,
        "plate": null,})
          .then((_) => print('add: $element'))
          .catchError((onError){
        print('Error adding initial database data. $onError');
      });
    });
  }

  Stream<DatabaseEvent> getSpotsReference() {
    return ref.child('spots')
        .onValue;
  }

  Stream<DatabaseEvent> getHistoryReference() {
    int todayReference = DateConverter.convertToDateOnlyTimestamp(DateTime.now());
    return ref.child('history/$todayReference')
        .onValue;
  }
  
  addVehicleInSpot({required Spot spot, required SpotHistory history}){
    updateSpot(spot);
    addHistory(spot: spot, history: history);
  }

  updateSpot(Spot spot){
    try {
      ref.child('spots/${spot.id}')
          .update(spot.toJson());
    } catch (e) {
      print(e);
    }
  }

  addHistory({required Spot spot, required SpotHistory history}){
    try{
      int timestamp = DateConverter.convertToDateOnlyTimestamp(history.inDateTime ?? DateTime.now());
      String datePath = "$timestamp";
      /*cria um valor no banco e salva a referencia na key*/
      var myRef = ref.child('history')
      .child(datePath)
      .push();
      String key = myRef.key.toString();
      history.key = key;
      spot..key = key;

      ref.child('history/$timestamp/$key')
          .update(history.toRTDBJson());
      updateSpot(spot);
    } catch(e){
      print(e);
    }
  }

  removeVehicleFromSpot({required Spot spot, required SpotHistory history}){
    try {
      int timestamp = DateConverter.convertToDateOnlyTimestamp(spot.inDateTime ?? DateTime.now());
      String datePath = "$timestamp";
      ref.child('spots/${spot.id}')
          .update(spot.toJson());

      ref.child('history/$timestamp/${history.key}')
      .update(history.toRTDBJson());
    } catch (e){
      print(e);
    }
  }

  testFunction() {
    // locator<SpotController>().vehicleIn(
    //     spot: Spot(id: 6, plate: "k3r44j3"),
    // );
    // removeVehicleFromSpot(
    //     spot: Spot(id: 6, plate: "asdasd", outDateTime: DateTime.now()),
    //   history: SpotHistory(spotId: 6, outDateTime: DateTime.now(),
    //     key: "-MygOZ5mxXRXAVtIIL7C",
    //   )
    // );
  }

}