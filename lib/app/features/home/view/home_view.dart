library home_view;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/service/MenuController.dart';
import '../../../../core/service/servicelocator.dart';
import '../controller/home_controller.dart';
import '../controller/intentlistener.dart';
import '../controller/setcustomurl.dart';
import 'components/qr_generator.dart';
import 'components/qr_scanner.dart';
import 'components/widget/custom_url/custom_url.dart';
import 'components/widget/my_drawer_header.dart';
import 'components/widget/vcard/form_vcard.dart';
import 'components/widget/wifi/wifi_dialog.dart';
part 'components/widget/drawer.dart';

class HomePage extends StatefulWidget {
  // String? incomingText;
  // String? incomingImage;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[QrCodeScanner(), QrCodeGenerator()];
  MenuController get menuController => ServiceLocator.get<MenuController>();
  IntentImage get intentImage => ServiceLocator.get<IntentImage>();
  IntentText get intentText => ServiceLocator.get<IntentText>();
  // BannerAd? _banner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    intentImage.imagePathStream.asBroadcastStream().listen((data) {
      if (data != null && data != "") {
        setState(() {
          _selectedIndex = 0;
        });
      }
    }, cancelOnError: false);
    intentText.textStream.asBroadcastStream().listen((data) {
      if (data != null && data != "") {
        setState(() {
          _selectedIndex = 1;
        });
      }
    }, cancelOnError: false);
    // if (widget.incomingText != null && widget.incomingText != "") {
    //   setState(() {
    //     _selectedIndex = 1;
    //   });
    // }
    // if (widget.incomingImage != null && widget.incomingImage != "") {
    //   setState(() {
    //     _selectedIndex = 0;
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      drawer: _Drawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: ("Scan QR Code"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: ("Create QR Code"),
          )
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        iconSize: 35,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
