import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raro_estacionamento/controllers/spot_controller.dart';
import 'package:raro_estacionamento/views/my_spots/components/spot_card.dart';

class MySpots extends StatelessWidget {
  const MySpots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Vagas: ',
        ),
        Consumer<SpotController>(builder: (_, spotController, __ ){
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: spotController.spots.length,
            itemBuilder: (context, index){
              return SpotCard(spot: spotController.spots[index]);
            },
          );
        }),
      ],
    );
  }
}
