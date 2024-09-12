import 'package:flutter/material.dart';

class SolderContentWidget extends StatelessWidget {
  String? title1;
  String? content1;
  String? content2;
  String? title2;

  SolderContentWidget({
    super.key,
    this.content1,
    this.content2,
    this.title1,
    this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: title1 == null || title2 == null
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1 ?? '',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  content1 ?? '',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title2 ?? '',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  content2 ?? '',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
