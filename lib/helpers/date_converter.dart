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

}