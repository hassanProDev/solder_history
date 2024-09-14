import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:solder_history/data/model/solder_model.dart';

int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;

  if (month2 > month1 ||
      (month1 == month2 && currentDate.day < birthDate.day)) {
    age--;
  }

  return age;
}

int calculateSpecificAge(
    {required DateTime birthDate, required DateTime specificDate}) {
  int age = specificDate.year - birthDate.year;
  int month1 = specificDate.month;
  int month2 = birthDate.month;

  if (month2 > month1 ||
      (month1 == month2 && specificDate.day < birthDate.day)) {
    age--;
  }

  return age;
}
 String androidId="";
void getDeviceId()async{
  if(Platform.isAndroid)  {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    androidId=androidInfo.id;
  }
}

class Extra {}
