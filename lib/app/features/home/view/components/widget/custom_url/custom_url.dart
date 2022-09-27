import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/setcustomurl.dart';

TextEditingController _textFieldController = TextEditingController();
CustomUrl custoURL = CustomUrl();

Future<void> displayCustomURLTextInputDialog(BuildContext context) async {
  return await showDialog(
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
              Get.back();
            },
          ),
          TextButton(
            child: Text('Set'),
            onPressed: () {
              custoURL.customurl = _textFieldController.text.trim();

              Get.back();
            },
          ),
        ],
      );
    },
  );
}
