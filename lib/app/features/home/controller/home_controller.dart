import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class HomeController extends GetxController {
  TextEditingController qrContentEditingcontroller = TextEditingController();
  var qrCode = "".obs;
  var scannedQrCode = "".obs;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> scanQR() async {
    try {
      scannedQrCode.value = await FlutterBarcodeScanner.scanBarcode(
        "#5fa693", //todo change
        "cancel".tr,
        true, //can change or dynamic
        ScanMode.QR,
      );
    } on PlatformException {
      scannedQrCode.value = "Failed to get QR".tr; //to add in language locale
    }
  }

  _savedQR_Gallery(image) async {
    final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }

  String? _getTextIntent() {
    try {
      return Get.parameters['text'];
    } catch (_) {
      return null;
    }
  }
}
