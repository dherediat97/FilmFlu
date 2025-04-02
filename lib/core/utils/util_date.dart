import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:intl/intl.dart';

String? parseDate(String date) {
  if (date.isEmpty) return null;

  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);

  var outputFormat = DateFormat('dd/MM/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

String? getYear(MediaItemEntity mediaItem) {
  String? date;
  if (mediaItem.releaseDate.isNotEmpty) {
    date = mediaItem.releaseDate;
  } else if (mediaItem.firstAirDate.isNotEmpty) {
    date = mediaItem.firstAirDate;
  }

  if (date!.isEmpty) return null;

  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);

  var outputFormat = DateFormat('yyyy');
  var year = outputFormat.format(inputDate);
  return year;
}
