import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/service/MenuController.dart';
import '../../../../../core/service/servicelocator.dart';
import '../../controller/home_controller.dart';
import 'ButtonWidget.dart';

class QrCodeScanner extends GetView<HomeController> {
  MenuController get menuController => ServiceLocator.get<MenuController>();
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
        leading: Center(
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.green,
            ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   "[ Skany Result ]", //todo add in locale
              //   style: TextStyle(
              //       fontSize: 16,
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 8,
              ), //controller.scannedQrCode.value
              // .toString()
              Obx(
                () => (controller.scannedQrCode.value.length > 0)
                    ? Container(
                        height: 150,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Center(
                            child: SelectableText(
                              controller.scannedQrCode.value.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        )).paddingOnly(top: 8, left: 3, right: 3)
                    : Container(),
              ), //dynamic this todo
              // Obx(
              //   () =>

              //   // SelectableText(
              //   //   onTap: () {}, //todo url launcher and regex
              //   //   controller.scannedQrCode.value.toString(),
              //   //   style: TextStyle(
              //   //       fontSize: 26,
              //   //       color: Colors.blueAccent,
              //   //       fontWeight: FontWeight.bold),
              //   // ),
              // ),
              SizedBox(
                height: 1,
              ),
              buttonGroup(),
              SizedBox(
                height: 2,
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
                height: 100,
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: controller.scannedQrCode.value.toString()))
                        .then((_) {
                      Get.snackbar("Copy Success", "Copied to clipboard",
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
                height: 100,
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
                height: 100,
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
