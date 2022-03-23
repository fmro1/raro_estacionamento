import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter{
  static int convertToDateOnlyTimestamp(DateTime dateTime){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    DateTime dateFormatted = DateTime.parse(formatted);
    return dateFormatted.millisecondsSinceEpoch;
  }

  static String dateToString(DateTime dateTime, {String format = "dd/MM/yyyy"}){
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static DateTime convertValuesToDatetime(DateTime date, TimeOfDay time){
    try {
      DateTime newDate =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      return newDate;
    } catch(e) {
      print(e);
      return DateTime(1500);
    }
  }

}