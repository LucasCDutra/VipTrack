extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

String getFirstName(String? name) {
  return name?.split(' ')[0] ?? '$name';
}

String formatFullName(String name) {
  return name.toTitleCase();
}

String formatFirstName(String? name) {
  String r = getFirstName(name);
  r = r.toCapitalized();
  return r;
}

String? getSplitDataInfo(String date, String type) {
  List<String> d = date.split('/');

  switch (type) {
    case 'd':
      return d[0];
    case 'm':
      return getMonth(d[1]);
    case 'a':
      return d[2];
  }
}

String getMonth(String m) {
  String mes = 'JAN';
  switch (m) {
    case '01':
      mes = 'JAN';
      break;
    case '02':
      mes = 'FEV';
      break;
    case '03':
      mes = 'MAR';
      break;
    case '04':
      mes = 'ABR';
      break;
    case '05':
      mes = 'MAI';
      break;
    case '06':
      mes = 'JUN';
      break;
    case '07':
      mes = 'JUL';
      break;
    case '08':
      mes = 'AGO';
      break;
    case '09':
      mes = 'SET';
      break;
    case '10':
      mes = 'OUT';
      break;
    case '11':
      mes = 'NOV';
      break;
    case '12':
      mes = 'DEZ';
      break;
  }

  return mes;
}
