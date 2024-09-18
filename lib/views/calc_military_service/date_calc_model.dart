import 'package:flutter/material.dart';

class DateClcModel {
  int day;
  int month;
  int year;
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  DateClcModel({ this.day=0,  this.month=0,  this.year=0});

  DateClcModel calcProcess({required DateClcModel date1, required DateClcModel date2}) {
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

  DateClcModel fromControllerToInt() {
    return DateClcModel(
      day: int.parse(dayController.text==""?"0":dayController.text),
      month: int.parse(monthController.text==""?"0":monthController.text),
      year: int.parse(yearController.text==""?"0":yearController.text),
    );
  }
}