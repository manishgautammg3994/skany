import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/config/theme/app_basic_theme.dart';
import '../../../../../../core/config/theme/helper/themeviewmodel.dart';
import '../../../../../../core/config/translation/helper/widget/language_picker_widget.dart';
import '../../../../../../core/service/MenuController.dart';
import '../../../../../../core/service/servicelocator.dart';
import '../../../controller/home_controller.dart';

class MyHeaderDrawer extends StatefulWidget {
  MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  ThemeViewModel get isDarkMode => ServiceLocator.get<ThemeViewModel>();

  MenuController get menuController => ServiceLocator.get<MenuController>();

  @override
  Widget build(BuildContext context) {
    // var uuid = FirebaseAuth.instance.currentUser!.uid; //done

    return SafeArea(
      child: Container(
        color: Colors.green[700],
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.only(top: 20.0),
        child: Stack(
          children: [
            Positioned(
              top: -15,
              left: 0,
              child: IconButton(
                hoverColor: Colors.grey,
                onPressed: menuController.controlcloseMenu,
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
              ),
            ),
            // Positioned(top: -15, left: 10, child: LanguageWidget()),
            // Positioned(top: -15, right: 10, child: LanguagePickerWidget()),
            Positioned(
              top: -10,
              right: 0,
              child: IconButton(
                hoverColor: Colors.grey,
                onPressed: () {
                  {
                    setState(() {
                      isDarkMode.darkMode = !isDarkMode.darkMode;
                    });
                  }
                },
                icon: Icon(
                  isDarkMode.darkMode
                      ? Icons.brightness_7_rounded
                      : Icons.nights_stay,
                  color:
                      isDarkMode.darkMode ? Colors.white54 : Colors.grey[600],
                  size: 35,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: Image.asset("assets/images/icon.png").image, //TODO
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
