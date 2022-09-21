import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController qrContentEditingcontroller = TextEditingController();
  var qrCode = "".obs;
  var scannedQrCode = "".obs;
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
      scannedQrCode.value = "Failed to get QR"; //to add in language locale
    }
  }
}
