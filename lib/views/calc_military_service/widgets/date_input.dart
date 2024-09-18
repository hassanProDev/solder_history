import "package:flutter/material.dart";

class DateInput extends StatelessWidget {
  DateInput({super.key, required this.text,  this.controller});

  String text;
  TextEditingController ?controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          label: Text(text),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}