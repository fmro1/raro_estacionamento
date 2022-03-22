import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.topPadding = 16.0,
    required this.textName,
    this.textInputType,
    this.validator,
    this.textEditingController,
    this.enabled = true,
  }) : super(key: key);
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final double topPadding;
  final String textName;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: topPadding,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Text(
                  textName,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textEditingController,
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            validator: validator,
            enabled: enabled,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withAlpha(120))),
                border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                hintText: hintText),
          ),
        ),
      ],
    );
  }
}