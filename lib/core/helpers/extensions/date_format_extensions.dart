import 'package:intl/intl.dart';

extension CustomDateFormat on DateFormat {
  static DateFormat get yyyymmdd => DateFormat('yyyy-MM-dd', 'en_US');

  String formatToYyyymmdd(DateTime date) {
    return yyyymmdd.format(date);
  }

  DateTime formatFromYyyymmdd(String date) {
    return yyyymmdd.parse(date);
  }
}
