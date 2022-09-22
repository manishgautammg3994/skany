import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import 'ButtonWidget.dart';

class QrCodeScanner extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
          onPressed: () => controller.scanBytes(),
          tooltip: 'Take a Photo',
          child: const Icon(Icons.camera_alt),
        ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "SKANY",
          style: TextStyle(
              color: Colors.black87, fontFamily: "Sofia"), //where is sofia
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "[ Skany Result ]", //todo add in locale
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(
              () => SelectableText(
                onTap: () {}, //todo url launcher and regex
                controller.scannedQrCode.value.toString(),
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWidget(
                  color: Colors.white,
                  text: "Scan QR Code",
                  onClicked: () => controller.scan(),
                ),
                Spacer(),
                ButtonWidget(
                  color: Colors.white,
                  text: "Scan From File",
                  onClicked: () => controller.scanPhoto(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
