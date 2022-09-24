import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void controlcloseMenu() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Get.back();
    }
  }
}
