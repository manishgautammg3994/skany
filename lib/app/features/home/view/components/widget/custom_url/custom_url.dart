import 'package:flutter/material.dart';

import '../../../../controller/setcustomurl.dart';

TextEditingController _textFieldController = TextEditingController();
CustomUrl custoURL = CustomUrl();

Future<void> displayCustomURLTextInputDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('TextField in Dialog'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Set Your Custom URL"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Set'),
            onPressed: () {
              custoURL.customurl = _textFieldController.text.trim();
              print(_textFieldController.text);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
