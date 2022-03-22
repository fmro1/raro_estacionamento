import 'package:flutter/material.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';
import 'package:raro_estacionamento/models/spot.dart';

class SpotCard extends StatelessWidget {
  const SpotCard({Key? key,
  required this.spot,
  }) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('tap');
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
                    color: spot.plate == null ? Colors.green.shade400 : Colors.red.shade400,
                    child: Center(
                      child: Text('${spot.id}',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kVPadding/2, horizontal: kHPadding/2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Vaga ${spot.id}',
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      Text(spot.plate ?? 'Livre'),
                      Text('${spot.inDateTime ?? ''}'),

                    ],
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
