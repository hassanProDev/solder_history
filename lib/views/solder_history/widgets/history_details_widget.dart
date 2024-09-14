import 'package:flutter/material.dart';

class HistoryDetailsWidget extends StatelessWidget {
  HistoryDetailsWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
