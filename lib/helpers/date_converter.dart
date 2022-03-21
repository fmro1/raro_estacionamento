import 'package:intl/intl.dart';

class DateConverter{
  static int convertToDateOnlyTimestamp(DateTime dateTime){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    DateTime dateFormatted = DateTime.parse(formatted);
    return dateFormatted.millisecondsSinceEpoch;
  }
}