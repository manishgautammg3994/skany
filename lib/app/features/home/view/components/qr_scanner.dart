import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/service/MenuController.dart';
import '../../../../../core/service/servicelocator.dart';
import '../../controller/home_controller.dart';
import 'ButtonWidget.dart';

class QrCodeScanner extends GetView<HomeController> {
  static MenuController get menuController =>
      ServiceLocator.get<MenuController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.scanBytes(),
        tooltip: 'Take a Photo',
        child: const Icon(Icons.camera_alt),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => menuController.controlMenu(),
          ),
        ),
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
              height: 10,
            ),
            buttonGroup(),
            SizedBox(
              height: 15,
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

  Widget buttonGroup() {
    return Obx(() {
      return Visibility(
        visible: (controller.scannedQrCode.value.trim().isNotEmpty ||
                controller.scannedQrCode.value.trim() != "")
            ? true
            : false,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 120,
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: controller.scannedQrCode.value.toString()))
                        .then((_) {
                      Get.snackbar("Copy Success", "",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green);
                    });
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Image.asset('assets/images/copy.png'),
                        ),
                        Divider(height: 20),
                        Expanded(flex: 1, child: Text("Copy")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 120,
                child: InkWell(
                  onTap: () async {
                    controller.launchURL();
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Image.asset('assets/images/open.png'),
                        ),
                        Divider(height: 20),
                        Expanded(
                            flex: 1,
                            child: Text((controller.regExp.hasMatch(controller
                                    .scannedQrCode.value
                                    .trim()
                                    .toString()))
                                ? "Launch"
                                : "Open")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 120,
                child: InkWell(
                  onTap: () {
                    Share.share(controller.scannedQrCode.value.toString());
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Image.asset('assets/images/share.png'),
                        ),
                        Divider(height: 20),
                        Expanded(flex: 1, child: Text("Share")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
