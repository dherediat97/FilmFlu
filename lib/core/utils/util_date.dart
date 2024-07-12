import 'package:intl/intl.dart';

String? parseDate(String date) {
  if (date.isEmpty) return null;

  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);

  var outputFormat = DateFormat('dd/MM/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
