import 'package:flutter/material.dart';
import 'package:raro_estacionamento/default_constants/default_ui_sizes.dart';

class MainBigButton extends StatelessWidget {
  const MainBigButton({Key? key,
    this.backgroundColor,
    this.text,
    this.textColor,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? textColor;
  final String? text;
  final IconData? iconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        onTap: onTap ?? (){},
        child: Column(children: [
          SizedBox(height: 15,),
          Icon(iconData ?? null, color: textColor ?? Colors.black,),
          Text(text ?? '',
              style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: kMainButtonTextSize)
          ),
          SizedBox(height: 15,),
        ],),
      ),
    );
  }
}
