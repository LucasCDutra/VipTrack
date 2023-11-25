import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';

String getDropOffTime(DateTime datetime, num duration) {
  int minutes = (duration / 60).round();
  int seconds = (duration % 60).round();
  DateTime tripEndDateTime = datetime.add(Duration(minutes: minutes, seconds: seconds));
  String dropOffTime = UtilData.obterHoraHHMM(tripEndDateTime);
  return dropOffTime;
}
