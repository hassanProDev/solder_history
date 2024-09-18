import 'package:flutter/cupertino.dart';
import 'package:solder_history/views/calc_military_service/date_calc_model.dart';

class CalcDetails{
  // TextEditingController serviceDurationDay=TextEditingController();
  // TextEditingController serviceDurationMonth=TextEditingController();
  // TextEditingController serviceDurationYear=TextEditingController();
  //
  // TextEditingController serviceEndDay=TextEditingController();
  // TextEditingController serviceEndMonth=TextEditingController();
  // TextEditingController serviceEndYear=TextEditingController();
  //
  // TextEditingController serviceStartDay=TextEditingController();
  // TextEditingController serviceStartMonth=TextEditingController();
  // TextEditingController serviceStartYear=TextEditingController();
  //
  // TextEditingController absenceDay=TextEditingController();
  // TextEditingController absenceMonth=TextEditingController();
  // TextEditingController absenceYear=TextEditingController();
  //
  // TextEditingController attendanceDay=TextEditingController();
  // TextEditingController attendanceMonth=TextEditingController();
  // TextEditingController attendanceYear=TextEditingController();

  // TextEditingController lossDurationDay=TextEditingController();
  // TextEditingController lossDurationMonth=TextEditingController();
  // TextEditingController lossDurationYear=TextEditingController();

  DateClcModel attendance=DateClcModel();
  DateClcModel lossDuration=DateClcModel();
  DateClcModel absence=DateClcModel();
  DateClcModel serviceStart=DateClcModel();
  DateClcModel serviceEnd=DateClcModel();
  DateClcModel serviceDuration=DateClcModel();
  final formKey=GlobalKey<FormState>();

}