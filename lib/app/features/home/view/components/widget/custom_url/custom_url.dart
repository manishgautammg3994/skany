import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/setcustomurl.dart';

TextEditingController _textFieldController = TextEditingController();
CustomUrl custoURL = CustomUrl();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

Future<void> displayCustomURLTextInputDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Set Your Custom URL'),
        content: Form(
          key: formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null ||
                  value.trim() == "" ||
                  (!value.contains("https://") || !value.contains("http://"))) {
                return "Not a valid URL";
              } else {
                return null;
              }
            },
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Set Your Custom URL"),
          ),
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
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                custoURL.customurl = _textFieldController.text.trim();

                Get.back();
              }
            },
          ),
        ],
      );
    },
  );
}
