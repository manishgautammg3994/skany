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
              ),
              Obx(
                () => (controller.scannedQrCode.value.length > 0)
                    ? Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          elevation: 6,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(Icons.verified_user,
                                        size: 18, color: Colors.green),
                                    Text(' QR code Result',
                                        style: TextStyle(fontSize: 15)),
                                    Spacer(),
                                    // Icon(Icons.more_vert,
                                    //     size: 18, color: Colors.black54),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 30, bottom: 10),
                                child: Column(
                                  //controller.scannedQrCode.value.toString(),
                                  children: <Widget>[
                                    TextField(
                                      controller: TextEditingController(
                                          text: controller.scannedQrCode.value
                                              .toString()),
                                      enabled: false,
                                      // onChanged: (changed) {
                                      //   setState(() {
                                      //     isChanged = true;
                                      //   });
                                      // },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      minLines: 1,
                                      expands: true, //turn it off
                                    ),
                                    // SingleChildScrollView(
                                    //   child: SelectableText(
                                    //     onTap:
                                    //         () {}, //todo url launcher and regex
                                    //     controller.scannedQrCode.value.toString(),
                                    //     style: TextStyle(
                                    //         fontSize: 26,
                                    //         color: Colors.blueAccent,
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 7, left: 25, right: 25),
                                      // child: Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: <Widget>[
                                      //     Expanded(
                                      //       flex: 5,
                                      //       child: GestureDetector(
                                      //           child: Text(
                                      //             'Clear',
                                      //             style: TextStyle(
                                      //                 fontSize: 15,
                                      //                 color: Colors.blue),
                                      //             textAlign: TextAlign.left,
                                      //           ),
                                      //           onTap: () {
                                      //             controller.qrCodeinput.value ==
                                      //                 "";
                                      //             controller.bytes = Uint8List(0);
                                      //             controller
                                      //                 .qrContentEditingcontroller
                                      //                 .clear();
                                      //             controller.qrCodeinput.value =
                                      //                 "";
                                      //           }),
                                      //     ),
                                      //     Text('|',
                                      //         style: TextStyle(
                                      //             fontSize: 15,
                                      //             color: Colors.black26)),
                                      //     Expanded(
                                      //       flex: 5,
                                      //       child: GestureDetector(
                                      //         onTap: () async {
                                      //           controller.saveToGallery();
                                      //         },
                                      //         child: Text(
                                      //           (controller.bytes.isNotEmpty ||
                                      //                   controller.qrCodeinput
                                      //                           .value !=
                                      //                       "")
                                      //               ? 'Save'
                                      //               : "",
                                      //           style: TextStyle(
                                      //               fontSize: 15,
                                      //               color: Colors.blue),
                                      //           textAlign: TextAlign.right,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(height: 15, color: Colors.black26)

                              // Container(
                              //   child: Row(
                              //     children: <Widget>[
                              //       Icon(Icons.history,
                              //           size: 16, color: Colors.black38),
                              //       Text('  Generate History',
                              //           style: TextStyle(
                              //               fontSize: 14, color: Colors.black38)),
                              //       Spacer(),
                              //       Icon(Icons.chevron_right,
                              //           size: 16, color: Colors.black38),
                              //     ],
                              //   ),
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 10, vertical: 9),
                              // )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
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
