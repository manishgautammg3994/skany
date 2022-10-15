// ignore_for_file: deprecated_member_use

import "package:flutter/material.dart";

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 21),
      ),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onPressed: onClicked,
    );
  }
}
