import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
      // backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        title: Text(
          "SKANY",
          // style: TextStyle(
          //     color: Colors.black87, fontFamily: "Sofia"), //where is sofia
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
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.blue),
                            ),
                          ),
                        )).paddingOnly(left: 3, right: 3, top: 5)
                    : Container(
                        height: 150,
                      ),
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                    text: "Scan QR Code",
                    onClicked: () => controller.scan(),
                  ),
                  Spacer(),
                  ButtonWidget(
                    text: "Scan From File",
                    onClicked: () => controller.scanPhoto(),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Obx((() {
                if (controller.adsLoaded.value) {
                  return Container(
                    width: controller.banner?.size.width.toDouble(),
                    height: controller.banner?.size.height.toDouble(),
                    margin: EdgeInsets.only(bottom: 12),
                    child: AdWidget(ad: controller.banner!),
                  );
                } else {
                  return SizedBox(
                    height: 2,
                  );
                }
              })),
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
                height: 90,
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: controller.scannedQrCode.value.toString()))
                        .then((_) {
                      Get.snackbar("Copy Success", "Copied To Clipboard",
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
                height: 90,
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
                            child: Text((controller.scannedQrCode.value.isURL)
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
                height: 90,
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
