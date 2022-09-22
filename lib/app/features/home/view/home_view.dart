library home_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/service/MenuController.dart';
import '../../../../core/service/servicelocator.dart';
import 'components/qr_generator.dart';
import 'components/qr_scanner.dart';
part 'components/widget/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[QrCodeScanner(), QrCodeGenerator()];
  MenuController get menuController => ServiceLocator.get<MenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuController.scaffoldKey,
      drawer: _Drawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: ("scan_QR_code".tr),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: ("create_Qr_code".tr),
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
