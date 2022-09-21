// ignore_for_file: deprecated_member_use

import "package:flutter/material.dart";

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 23),
      ),
      shape: StadiumBorder(),
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textColor: Colors.black,
      onPressed: onClicked,
    );
  }
}
