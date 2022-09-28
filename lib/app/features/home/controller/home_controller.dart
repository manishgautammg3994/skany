import 'dart:io';
import 'dart:typed_data';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:share_plus/share_plus.dart';
import 'package:skany/app/features/home/controller/setcustomurl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:wifi_connector/wifi_connector.dart';

import '../../../../core/service/servicelocator.dart';
import '../view/components/widget/vcard/vcard_parser.dart';
import 'intentlistener.dart';

class HomeController extends GetxController {
  var wifiPattern = "(WIFI:S:)(.{1,32})(;T:)(WPA|WEP)(;P:)(.{1,32})(;;)";
  TextEditingController qrContentEditingcontroller = TextEditingController();

  static String pattern =
      r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
  RegExp regExp = RegExp(pattern);

  var qrCodeinput = "".obs;
  var scannedQrCode = "".obs;
  ScreenshotController screenshotController = ScreenshotController();
  var bytes = Uint8List(0);
  IntentImage get intentImage => ServiceLocator.get<IntentImage>();
  IntentText get intentText => ServiceLocator.get<IntentText>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    intentImage.imagePathStream.asBroadcastStream().listen(
      (data) {
        if (data != null && data.trim() != "") {
          //dont remove this trim()
          scanPath(data);
        }
      },
      cancelOnError: false,
    );
    intentText.textStream.asBroadcastStream().listen(
      (data) {
        if (data != null && data != "") {
          qrCodeinput.value = data;
          qrContentEditingcontroller.text = data;
          generateBarCode(data);
        }
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    intentImage.incomingImageController.close();
    intentText.incomingTextController.close();
  }
  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //    if (_getTextIntent() != null && _getFileIntent() != "") {
  //     qrCodeinput.value = _getTextIntent().toString();
  //     qrContentEditingcontroller.text = _getTextIntent().toString();
  //     generateBarCode(_getTextIntent().toString());
  //     update();
  //   }
  //   if (_getFileIntent() != null && _getFileIntent()?.trim() != "") {
  //     //dont remove this trim()
  //     scanPath(_getFileIntent()!.trim().toString());
  //     update();
  //   }
  //   super.onReady();

  // }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  _savedQR_Gallery(image) async {
    final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }

  // String? _getTextIntent() {
  //   try {
  //     return Get.arguments['incomingText'];
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // String? _getFileIntent() {
  //   try {
  //     return Get.arguments['incomingImage'];
  //   } catch (_) {
  //     return null;
  //   }
  // }

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

  Future<void> launchURL() async {
    if (scannedQrCode.value.startsWith("http://")) {
      await launchUrlString(scannedQrCode.value.toString());
      //launc url

    } else if (scannedQrCode.value.startsWith("tel:")) {
      await launch(scheme: "tel:", url: scannedQrCode.value.toString());
    } else if (scannedQrCode.value.startsWith("WIFI:")) {
      String? password;
      String? ssid;
      bool? isHidden = scannedQrCode.value.contains("true");
      bool? isWEP = scannedQrCode.value.contains("WEP");
      final RegExp passRegex =
          RegExp(r'(?<=P:)((?:\\[\\;,:])|(?:[^;]))+(?<!\\;)(?=;)');
      final RegExp ssidRegex =
          RegExp(r'(?<=S:)((?:\\[\\;,:])|(?:[^;]))+(?<!\\;)(?=;)');
      List<RegExpMatch> matchesssid =
          ssidRegex.allMatches(scannedQrCode.value.toString()).toList();
      List<RegExpMatch> matchespass =
          passRegex.allMatches(scannedQrCode.value.toString()).toList();
      for (var matchssid in matchesssid) {
        ssid = scannedQrCode.value.substring(matchssid.start, matchssid.end);
        // print(dummyString.contains("true"));

      }
      for (var matchpass in matchespass) {
        password =
            scannedQrCode.value.substring(matchpass.start, matchpass.end);
        // print(dummyString.contains("true"));

      }
      await WifiConnector.connectToWifi(
          ssid: (ssid != null && ssid.trim() != "") ? ssid : "",
          password:
              (password != null && password.trim() != "") ? password : null,
          isWEP: isWEP);
      //TODO
    } else if (scannedQrCode.value.startsWith("upi://")) {
      if (Platform.isAndroid) {
        AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: scannedQrCode.value,
        );
        await intent.launch();
      }
    }
    if (scannedQrCode.value.startsWith("BEGIN:VCARD") &&
        scannedQrCode.value.endsWith("END:VCARD")) {
      VCard vc = VCard(scannedQrCode.value.trim().toString());

      showModalBottomSheet(
          context: Get.context!,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.person),
                  title: new Text(vc.formattedName ?? ""),
                  onTap: () {
                    // Navigator.pop(context);
                  },
                ),
                for (var item in vc.typedEmail)
                  ListTile(
                    leading: new Icon(Icons.email),
                    title: new Text(item.toString()),
                    onTap: () async {
                      var _url = Uri.parse("mailto:${item.toString()}");
                      await launchUrl(
                        _url,
                      );
                      
                      Get.back();
                    },
                  ),
                for (var item in vc.typedTelephone)
                  ListTile(
                    leading: new Icon(Icons.phone),
                    title: new Text(item.toString()),
                    onTap: () async {
                      final Uri _phoneUri =
                          Uri(scheme: "tel", path: item.toString());
                      await launchUrl(
                        _phoneUri,
                      );
                      Get.back();
                    },
                  ),
                for (var item in vc.typedURL)
                  ListTile(
                    leading: new Icon(Icons.link),
                    title: new Text(item.toString()),
                    onTap: () {
                      launch(url: item.toString());
                      Get.back();
                    },
                  ),
              ],
            );
          });
    } else if (scannedQrCode.value.startsWith("https://")) {
      await launch(url: scannedQrCode.value.trim().toString());
    } else {
      String? pre = CustomUrl().customurl;
      var newquery = scannedQrCode.replaceAll(" ", "+"); //TODO encoding
      String fullUrl =
          (pre != null && pre.toString() != "") ? pre + newquery : newquery;
      await launch(url: fullUrl);
    }
  }

  Future shareGeneratedQr() async {
    try {
      final appDir = await syspaths.getTemporaryDirectory();
      File file = File('${appDir.path}/${DateTime.now()}.jpg');
      await file.writeAsBytes(bytes).then((value) {
        Share.shareFiles([file.path.toString()]);
      });
    } catch (e) {}
  }
}

Future<void> launch({String? scheme, String? url}) async {
  var _url = Uri.parse(url!);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url,
        mode: (scheme != null && scheme != "")
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication); //implement forceSafariVC for ios
  }
}
