import 'package:intl/intl.dart';

class FormatData {
  getDataFormat(DateTime date) {
    return DateFormat.Hm().format(date);
  }
}
