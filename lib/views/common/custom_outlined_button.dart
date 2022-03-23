import 'package:flutter/material.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({Key? key,
  required this.onTap,
    required this.text,
  }) : super(key: key);

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kHPadding/2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigoAccent),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$text',
                style: TextStyle(color: Colors.indigoAccent),),
            ),
          ),
        ),
      ),);
  }
}
