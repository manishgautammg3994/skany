import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math' as math;

import 'package:skany/app/features/home/controller/home_controller.dart';

class QrCodeGenerator extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
            backgroundColor: Colors.white70,
            title: Text(
              "SKANY",
              style: TextStyle(color: Colors.black87, fontFamily: "Sofia"),
            ),
            centerTitle: true,
            elevation: 0.0,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        var isGranted =
                            await Permission.manageExternalStorage.request();
                        if (isGranted.isGranted || isGranted.isLimited) {
                          var dir =
                              (await getExternalStorageDirectory())?.path ??
                                  (await getApplicationDocumentsDirectory())
                                      .path; //getExternalStorageDirectory();
                          controller.screenshotController.captureAndSave(
                              dir + r"\Skany",
                              // fileName:
                              //     "rr", //  "QR" + DateTime.now().toString() +".jpg",
                              pixelRatio: 4 / 3);
                        } else {
                          Get.snackbar(
                              "NO PERMISSION", "Storage Permission Not Granted",
                              backgroundColor: Colors.red);
                        }
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.black54, //todo
                      )).paddingOnly(right: 10.0)
                ],
              )
            ]),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Screenshot(
                controller: controller.screenshotController,
                child: QrImage(
                  data: controller.qrCode.value,
                  size: math.min(
                          Get.size.width, //create them adjustable
                          Get.size.height) /
                      1.3,
                  backgroundColor: Color.fromARGB(179, 255, 255, 255),
                  // foregroundColor: ,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            buildTextField(context),
          ],
        ))));
  }

  buildTextField(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(19),
        child: TextFormField(
          controller: controller.qrContentEditingcontroller,
          keyboardType: TextInputType.text,
          onChanged: ((val) {
            controller.qrCode.value = val;
          }),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          decoration: InputDecoration(
              hintText: "Enter Data",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Get.theme.primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              suffixIcon: (IconButton(
                  color: Color(0XFF5fa693),
                  icon: Icon(Icons.done, size: 30),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  }))),
        ));
  }
}
