import 'package:flutter/material.dart';
import 'package:solder_history/views/calc_military_service/widgets/date_input.dart';

class ClcDateWidget extends StatelessWidget {
  ClcDateWidget(
      {super.key,
        required this.text,
        required this.day,
        required this.month,
        required this.year});

  String text;
  TextEditingController day;
  TextEditingController month;
  TextEditingController year;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateInput(
                text: "يوم",
                controller: day,
              ),
              DateInput(
                text: "شهر",
                controller: month,
              ),
              DateInput(
                text: "سنة",
                controller: year,
              ),
            ],
          ),
        ],
      ),
    );
  }
}