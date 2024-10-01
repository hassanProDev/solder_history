import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/views/calc_military_service/date_calc_model.dart';

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

double calculateAgeDecimal(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int yearsDifference = currentDate.year - birthDate.year;
  int monthsDifference = currentDate.month - birthDate.month;
  int daysDifference = currentDate.day - birthDate.day;

  if (daysDifference < 0) {
    monthsDifference -= 1;
    daysDifference +=
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month - 1);
  }

  if (monthsDifference < 0) {
    yearsDifference -= 1;
    monthsDifference += 12;
  }

  double ageDecimal =
      yearsDifference + (monthsDifference / 12) + (daysDifference / 365.25);
  return ageDecimal;
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

String androidId = "";

void getDeviceId() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    androidId = androidInfo.id;
    // print(androidId);
  }
}

DateClcModel calcProcess(
    {required DateClcModel date1, required DateClcModel date2}) {
  if (date1.day == 0 && date1.month == 0 && date1.year == 0) {
    DateTime dateTime = DateTime.now();
    date1.day = dateTime.day;
    date1.month = dateTime.month;
    date1.year = dateTime.year;
  }
  if (date2.day == 0 && date2.month == 0 && date2.year == 0) {
    DateTime dateTime = DateTime.now();
    date2.day = dateTime.day;
    date2.month = dateTime.month;
    date2.year = dateTime.year;
  }
  if (date1.day < date2.day) {
    if (date1.month == 0) {
      date1.year -= 1;
      date1.month += 11;
      date1.day += 30;
    } else {
      date1.month -= 1;
      date1.day += 30;
    }
  }
  if (date1.month < date2.month) {
    date1.year -= 1;
    date1.month += 12;
  }
  date1.day -= date2.day;
  date1.month -= date2.month;
  date1.year -= date2.year;
  return date1;
}

class Extra {}
