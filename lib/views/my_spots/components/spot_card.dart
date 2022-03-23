import 'package:flutter/material.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/helpers/date_converter.dart';
import 'package:raro_estacionamento/locator.dart';
import 'package:raro_estacionamento/models/spot.dart';
import 'package:raro_estacionamento/views/add_vehicle_view/add_vehicle_view.dart';
import 'package:raro_estacionamento/views/common/create_route.dart';
import 'package:raro_estacionamento/views/remove_vehicle_view/remove_vehicle_view.dart';

class SpotCard extends StatelessWidget {
  const SpotCard({Key? key,
  required this.spot,
  }) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        locator<SpotController>().isSpotInUse(spot: spot)
            ? Navigator.of(context).push(CreateRoute.pushRoute(RemoveVehicleView(spot: spot,)))
            : Navigator.of(context).push(CreateRoute.pushRoute(AddVehicleView(spot: spot,)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultRadius),
                    bottomLeft: Radius.circular(kDefaultRadius)
                  ),
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.15,
                    color: locator<SpotController>().isSpotInUse(spot: spot)
                        ? Colors.green.shade400
                        : Colors.red.shade400,
                    child: Center(
                      child: Text('${spot.id}',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: kVPadding/2, horizontal: kHPadding/2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Vaga ${spot.id}',
                          style: TextStyle(fontSize: kTextSize),
                        ),
                        Text(((){
                          if(spot.plate == null){
                            return "Livre";
                          } else {
                            return "Placa: ${spot.plate}";
                          }
                        }())),
                        Text("Entrada: " + ((){
                          if(spot.inDateTime == null){
                            return "-";
                          } else {
                            return "${DateConverter.dateToString(spot.inDateTime!, format: "dd/MM - HH:mm")}";
                          }
                        }())),
                        if(spot.error != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text("${spot.error}",
                                  style: defaultStyle,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
