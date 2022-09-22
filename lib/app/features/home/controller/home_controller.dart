import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomeController extends GetxController {
  TextEditingController qrContentEditingcontroller = TextEditingController();

  var qrCodeinput = "".obs;
  var scannedQrCode = "".obs;
  ScreenshotController screenshotController = ScreenshotController();
  var bytes = Uint8List(0);
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

  Future generateBarCode(String inputCode) async {
    if (inputCode.isNotEmpty) {
      Uint8List result = await scanner.generateBarCode(inputCode);

      bytes = result;
    }
  }

  Future<void> saveToGallery() async {
    if (bytes.isNotEmpty) {
      final success = await ImageGallerySaver.saveImage(this.bytes);
    } // ?? Uint8List(0)
  }

  Future scanPhoto() async {
    await Permission.storage.request();
    try {
      String barcode = await scanner.scanPhoto();
      scannedQrCode.value = barcode;
    } catch (e) {}
  }

  Future scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      scannedQrCode.value = barcode;
    }
  }

  Future scanPath(String path) async {
    await Permission.storage.request();
    String barcode = await scanner.scanPath(path);
    scannedQrCode.value = barcode;
  }

  Future scanBytes() async {
    try {
      File? file = await ImagePicker()
          .pickImage(source: ImageSource.camera)
          .then((picked) {
        if (picked == null) return null;
        return File(picked.path);
      });
      if (file == null) return;
      Uint8List bytes = file.readAsBytesSync();
      await ImageGallerySaver.saveImage(bytes);
      String barcode = await scanner.scanBytes(bytes); // try catch needed
      scannedQrCode.value = barcode;
    } catch (e) {}
  }
}
