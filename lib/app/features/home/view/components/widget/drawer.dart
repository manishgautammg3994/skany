part of home_view;

class _Drawer extends GetView<HomeController> {
  _Drawer({Key? key}) : super(key: key);
  IntentText get intentText => ServiceLocator.get<IntentText>();
  MenuController get menuController => ServiceLocator.get<MenuController>();
  List<bool> selections = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        //done
        child: Container(
          child: Column(
            children: [
              MyHeaderDrawer(),
              myDrawerList(
                  context: context,
                  selections: selections,
                  intentText: intentText,
                  menuController: menuController)
            ],
          ),
        ),
      ),

      //  Column(
      //   children: [
      //     SizedBox(height: 25),
      //     ListTile(
      //       leading: Icon(Icons.logout),
      //       title: Text("Logout"),
      //       onTap: () => controller.logout(),
      //     ),
      //   ],
      // ),
    );
  }
}

Widget myDrawerList(
    {required BuildContext context,
    required List<bool> selections,
    required IntentText intentText,
    required MenuController menuController}) {
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      children: [
        menuItem1(
            selections: selections,
            intentText: intentText,
            context: context,
            menuController: menuController),
        menuItem4(context: context, menuController: menuController),
        menuItem5(),
        menuItem6(),
        menuItem7(), //mkohlakalilucas7@gmail.com
        menuItem3(),
        Divider(),
        Divider(
          color: Colors.red[100],
          indent: 10,
          endIndent: 10,
          height: 10,
          thickness: 0.5,
        ),
        menuItem8(), //Exit
        Divider(
          color: Colors.red[100],
          indent: 10,
          endIndent: 10,
          height: 10,
          thickness: 0.5,
        ),
        // menuItem9(),
        // menuItem10(),
        // menuItem11(),
        // menuItem12(),
        // menuItem13(),
        // menuItem14(),
        // menuItem15(),
        // menuItem16(),
        // menuItem17(),
      ],
      //show the list of menu drawer
    ),
  );
}

Widget menuItem1(
    {required List<bool> selections,
    required BuildContext context,
    required IntentText intentText,
    required MenuController menuController}) {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
          padding: EdgeInsets.zero,
          child: ToggleButtons(
            onPressed: (index) async {
              //VcardForm
              //////////
              menuController.controlcloseMenu();
              if (index == 0) {
                await showWIFIDialog(context: context, intentText: intentText);
              }
              if (index == 1) {
                await Get.to(() => VcardForm(
                      intentText: intentText,
                    ));
              }
            },
            isSelected: selections,
            children: [Icon(Icons.wifi), Icon(Icons.credit_card)],
          )),
    ),
  );
}

Widget menuItem3() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.assignment_ind,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "About Us",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem4(
    {required BuildContext context, required MenuController menuController}) {
  CustomUrl custoURL = CustomUrl();
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () async {
            menuController.controlcloseMenu();
            return await displayCustomURLTextInputDialog(context);
          },
          child: TextField(
            enabled: false,
            controller: TextEditingController(text: custoURL.customurl),
            decoration: InputDecoration(
                hintText: "Set Your Custom URL", label: Text("Search On URL")),
          ),
        ),
      ),
    ),
  );
}

Widget menuItem5() {
  return Material(
    child: InkWell(
      onTap: () async {
        launch(
            url:
                "mailto:mkohlakalilucas7@gmail.com?subject=Bug_in_Skany&body=");
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.bug_report,
                size: 20,
                color: Colors.red[500],
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Report Bug",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem6() {
  return Material(
    child: InkWell(
      onTap: () async {
        launch(url: "https://zamil356.github.io/SKANY-/");
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.privacy_tip_outlined,
                size: 20,
                color: Colors.orangeAccent,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem7() {
  return Material(
    child: InkWell(
      onTap: () async {
        launch(
            url:
                "mailto:mkohlakalilucas7@gmail.com?subject=Feedback_of_Skany&body=");
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.feedback_outlined,
                size: 20,
                color: Colors.orange,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Feedback",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem8() {
  return Material(
    child: InkWell(
      onTap: () async {
        await SystemNavigator.pop();
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.logout,
                size: 20,
                color: Colors.redAccent,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Exit",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem9() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem10() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem11() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem12() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem13() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem14() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem15() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem17() {
  return Material(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.dashboard_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
// if (Platform.isAndroid) {
//           SystemNavigator.pop();
//         }
