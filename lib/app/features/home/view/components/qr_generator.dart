import 'dart:typed_data';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:screenshot/screenshot.dart';
import 'dart:math' as math;

import 'package:skany/app/features/home/controller/home_controller.dart';

import '../../../../../core/service/MenuController.dart';
import '../../../../../core/service/servicelocator.dart';

class QrCodeGenerator extends GetView<HomeController> {
  MenuController get menuController => ServiceLocator.get<MenuController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        actions: [
          Obx(() => (controller.qrCodeinput.value.length > 0)
              ? Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.green,
                      ),
                      onPressed: () => controller.shareGeneratedQr()),
                )
              : Container())
        ],
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
          style: TextStyle(color: Colors.black87, fontFamily: "Sofia"),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => (controller.qrCodeinput.value.length > 0 &&
                        controller.qrCodeinput.value != null)
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
                                    Text('  Generate Qrcode',
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
                                  children: <Widget>[
                                    Screenshot(
                                      controller:
                                          controller.screenshotController,
                                      child: SizedBox(
                                        height: 190,
                                        child: controller.bytes.isEmpty
                                            ? Center(
                                                child: Text('Empty code ... ',
                                                    style: TextStyle(
                                                        color: Colors.black38)),
                                              )
                                            : Image.memory(controller.bytes),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 7, left: 25, right: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 5,
                                            child: GestureDetector(
                                                child: Text(
                                                  'Clear',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue),
                                                  textAlign: TextAlign.left,
                                                ),
                                                onTap: () {
                                                  controller
                                                          .qrCodeinput.value ==
                                                      "";
                                                  controller.bytes =
                                                      Uint8List(0);
                                                  controller
                                                      .qrContentEditingcontroller
                                                      .clear();
                                                  controller.qrCodeinput.value =
                                                      "";
                                                }),
                                          ),
                                          Text('|',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black26)),
                                          Expanded(
                                            flex: 5,
                                            child: GestureDetector(
                                              onTap: () async {
                                                controller.saveToGallery();
                                              },
                                              child: Text(
                                                (controller.bytes.isNotEmpty ||
                                                        controller.qrCodeinput
                                                                .value !=
                                                            "")
                                                    ? 'Save'
                                                    : "",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blue),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
              SizedBox(
                height: 1,
              ),
              buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  buildTextField(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(19, 2, 19, 10),
        child: TextFormField(
          autocorrect: false,
          // autovalidateMode: AutovalidateMode.always,
          toolbarOptions: ToolbarOptions(
              copy: true, paste: true, selectAll: true, cut: true),
          controller: controller.qrContentEditingcontroller,
          keyboardType: TextInputType.text,
          onChanged: ((val) {
            controller.qrCodeinput.value = val;
            controller.generateBarCode(val);
          }),
          onSaved: (val) async {
            controller.qrCodeinput.value = val ?? "";
            controller.generateBarCode(controller.qrCodeinput.value);
          },
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
                    controller.generateBarCode(controller.qrCodeinput.value);
                  }))),
        ));
  }

  //  qrCodeWidget(
  //     {required Uint8List bytes, required BuildContext context}) {
  //   return Padding(
  //     padding: EdgeInsets.all(20),
  //     child: Card(
  //       elevation: 6,
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: <Widget>[
  //                 Icon(Icons.verified_user, size: 18, color: Colors.green),
  //                 Text('  Generate Qrcode', style: TextStyle(fontSize: 15)),
  //                 Spacer(),
  //                 Icon(Icons.more_vert, size: 18, color: Colors.black54),
  //               ],
  //             ),
  //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
  //             decoration: BoxDecoration(
  //               color: Colors.black12,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(4), topRight: Radius.circular(4)),
  //             ),
  //           ),
  //           Padding(
  //             padding:
  //                 EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
  //             child: Column(
  //               children: <Widget>[
  //                 Screenshot(
  //                   controller: controller.screenshotController,
  //                   child: SizedBox(
  //                     height: 190,
  //                     child: bytes.isEmpty
  //                         ? Center(
  //                             child: Text('Empty code ... ',
  //                                 style: TextStyle(color: Colors.black38)),
  //                           )
  //                         : Image.memory(bytes),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 7, left: 25, right: 25),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: <Widget>[
  //                       Expanded(
  //                         flex: 5,
  //                         child: GestureDetector(
  //                             child: Text(
  //                               'Clear',
  //                               style:
  //                                   TextStyle(fontSize: 15, color: Colors.blue),
  //                               textAlign: TextAlign.left,
  //                             ),
  //                             onTap: () {
  //                               controller.qrCodeinput.value == "";
  //                               controller.bytes = Uint8List(0);
  //                             }),
  //                       ),
  //                       Text('|',
  //                           style:
  //                               TextStyle(fontSize: 15, color: Colors.black26)),
  //                       Expanded(
  //                         flex: 5,
  //                         child: GestureDetector(
  //                           onTap: () async {
  //                             controller.saveToGallery();
  //                           },
  //                           child: Text(
  //                             'save',
  //                             style:
  //                                 TextStyle(fontSize: 15, color: Colors.blue),
  //                             textAlign: TextAlign.right,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Divider(height: 2, color: Colors.black26),
  //           Container(
  //             child: Row(
  //               children: <Widget>[
  //                 Icon(Icons.history, size: 16, color: Colors.black38),
  //                 Text('  Generate History',
  //                     style: TextStyle(fontSize: 14, color: Colors.black38)),
  //                 Spacer(),
  //                 Icon(Icons.chevron_right, size: 16, color: Colors.black38),
  //               ],
  //             ),
  //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
