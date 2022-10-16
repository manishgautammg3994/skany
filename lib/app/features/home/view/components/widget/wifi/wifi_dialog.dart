import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/service/servicelocator.dart';
import '../../../../controller/intentlistener.dart';

Future showWIFIDialog(
    {required BuildContext context, required IntentText intentText}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      bool isChecked = false;
      // var space
      bool isPasswFieldVisible = true;
      TextEditingController ssidCont = TextEditingController();
      TextEditingController passCont = TextEditingController();
      GlobalKey<FormState> formKey = GlobalKey<FormState>();
      String selectedType = "WPA/WPA2PSK";
      String? finalStringwifi;

      return StatefulBuilder(builder: (BuildContext context, setState) {
        return Container(
          child: AlertDialog(
            title: Text('WIFI QR'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null && value?.trim() == "") {
                        return "Enter SSID";
                      } else {
                        if (value!.contains("?") ||
                            value.contains('"') ||
                            value.contains('\$') ||
                            value.contains("\\") ||
                            value.contains('[') ||
                            value.contains(']') ||
                            value.contains('+')) {
                          return "remove Special character ";
                        } else {
                          return null;
                        }
                      }
                    },
                    controller: ssidCont,
                    decoration: InputDecoration(hintText: "Enter SSID"),
                  ),
                ),
                Visibility(
                  visible: isPasswFieldVisible,
                  child: Form(
                    key: isPasswFieldVisible ? formKey : null,
                    child: TextFormField(
                      controller: passCont,
                      decoration: InputDecoration(hintText: "Enter Password"),
                    ),
                  ),
                ).paddingOnly(top: 2, bottom: 2),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedType,
                    onChanged: ((value) {
                      setState(() {
                        if (value == "None") {
                          isPasswFieldVisible = false;
                          selectedType = value!;
                        } else if (value == "WEP") {
                          isPasswFieldVisible = true;
                          selectedType = value!;
                        } else if (value == "WPA/WPA2PSK") {
                          isPasswFieldVisible = true;
                          selectedType = value!;
                        }
                      });
                    }),
                    items: typesWifi.map((type) {
                      //any function
                      return DropdownMenuItem(
                        value: type,
                        child: Center(
                          child: Text(type!),
                        ),
                      );
                    }).toList(),
                  ),
                ).paddingOnly(top: 2, bottom: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Hidden"),
                    Checkbox(
                        value: isChecked,
                        onChanged: (checked) {
                          setState((() {
                            isChecked = checked!;
                          }));
                        })
                  ],
                ).paddingOnly(top: 2, bottom: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      child: Text('CANCEL'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: Text('OK'),
                      onPressed: () async {
                        formKey.currentState!.validate();
                        String hiddenString =
                            (isChecked) ? "H:${isChecked.toString()};" : "";
                        if ((ssidCont.text.length > 0 &&
                            ssidCont.text != null)) {
                          if (selectedType == "WPA/WPA2PSK" &&
                              passCont.text.length > 7) {
                            finalStringwifi = "WIFI:T:WPA;" +
                                "P:" "${passCont.text.toString()}" +
                                ";S:" +
                                "${ssidCont.text.toString()}" + //REMOVE THESE EXTRA ""
                                ";" +
                                hiddenString;
                            intentText.incomingTextController.sink
                                .add(finalStringwifi.toString());
                            Get.back();
                          } else if (selectedType == "WEP" &&
                              passCont.text.length > 7) {
                            finalStringwifi = "WIFI:T:WEP;" +
                                "P:" "${passCont.text.toString()}" +
                                ";S:" +
                                "${ssidCont.text.toString()}" + //REMOVE THESE EXTRA ""
                                ";" +
                                hiddenString;
                            intentText.incomingTextController.sink
                                .add(finalStringwifi.toString());
                            Get.back();
                          } else if (selectedType == "None") {
                            finalStringwifi = "WIFI:T:nopass;" + //to modify
                                "P:" +
                                ";S:" +
                                "${ssidCont.text.toString()}" + //REMOVE THESE EXTRA ""
                                ";" +
                                hiddenString;
                            intentText.incomingTextController.sink
                                .add(finalStringwifi.toString());
                            Get.back();
                          }
                        }
                      },
                    ),
                  ],
                ).paddingOnly(top: 2, bottom: 2)
              ],
            ),
          ),
        );
      });
    },
  );
}

List<String?> typesWifi = [
  "None",
  "WEP",
  "WPA/WPA2PSK",
];
//WIFI:    // S: ;  //T: ; //P: ; //H: ;        WEP|WPA|nopass //but in nopass youhave to pass P:;

// class WifiWidget extends StatefulWidget {
//   final IntentText intentText;
//   const WifiWidget({Key? key, required this.intentText}) : super(key: key);

//   @override
//   State<WifiWidget> createState() => _WifiWidgetState();
// }

// class _WifiWidgetState extends State<WifiWidget> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   bool isChecked = false;
//   // var space
//   bool isPasswFieldVisible = true;
//   TextEditingController ssidCont = TextEditingController();
//   TextEditingController passCont = TextEditingController();
//   String selectedType = "WPA/WPA2PSK";
//   String? finalStringwifi;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(children: [
//           Form(
//             key: formKey,
//             child: TextFormField(
//               validator: ((value) {
//                 if (value == "" || value == null) {
//                   return "Please Enter a Valid SSID";
//                 } else {
//                   return null;
//                 }
//               }),
//               controller: ssidCont,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                   hintText: "Enter SSID",
//                   hintStyle: TextStyle(
//                     color: Colors.black,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Get.theme.primaryColor,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Get.theme.primaryColor,
//                     ),
//                   ),
//                   suffixIcon: (IconButton(
//                       color: Color.fromARGB(255, 239, 16, 16),
//                       icon: Icon(
//                         Icons.cancel,
//                       ),
//                       onPressed: () {
//                         ssidCont.clear();
//                       }))),
//             ),
//           ),
//           Visibility(
//               visible: isPasswFieldVisible,
//               child: Form(
//                 key: isPasswFieldVisible ? formKey : null,
//                 child: TextFormField(
//                   controller: isPasswFieldVisible ? passCont : null,
//                   keyboardType: TextInputType.text,
//                   validator: ((value) {
//                     if ((selectedType == "WEP" ||
//                             selectedType == "WPA/WPA2PSK") &&
//                         (value == null || value == "")) {
//                       return "Enter a Valid Password";
//                     } else {
//                       return null;
//                     }
//                     //TODO
//                   }),
//                   decoration: InputDecoration(
//                       hintText: "Enter Password",
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                         borderSide: BorderSide(
//                           color: Get.theme.primaryColor,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       suffixIcon: (IconButton(
//                           color: Color.fromARGB(255, 109, 107, 107),
//                           icon: Icon(
//                             Icons.cancel,
//                           ),
//                           onPressed: () {
//                             passCont.clear();
//                           }))),
//                 ),
//               )),
//           DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               value: selectedType,
//               onChanged: ((value) {
//                 setState(() {
//                   if (value == "None") {
//                     isPasswFieldVisible = false;
//                     selectedType = value!;
//                   } else if (value == "WEP") {
//                     isPasswFieldVisible = true;
//                     selectedType = value!;
//                   } else if (value == "WPA/WPA2PSK") {
//                     isPasswFieldVisible = true;
//                     selectedType = value!;
//                   }
//                 });
//               }),
//               items: typesWifi.map((type) {
//                 //any function
//                 return DropdownMenuItem(
//                   value: type,
//                   child: Center(
//                     child: Text(type!),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text("Hidden"),
//               Checkbox(
//                   value: isChecked,
//                   onChanged: (checked) {
//                     setState((() {
//                       isChecked = checked!;
//                     }));
//                   })
//             ],
//           ),
//         ]),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             TextButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text("Cancel")),
//             TextButton(
//                 onPressed: () async {
//                   String hiddenString =
//                       (isChecked) ? "H:${isChecked.toString()};" : "";
//                   if (formKey.currentState!.validate()) {
//                     if (selectedType == "WPA/WPA2PSK") {
//                       finalStringwifi = "WIFI:T:WPA;" +
//                           "P:" "${passCont.text.toString()}" +
//                           ";S:" +
//                           "${ssidCont.text.toString()}" + //REMOVE THESE EXTRA ""
//                           ";" +
//                           hiddenString;
//                     } else if (selectedType == "WEP") {
//                       finalStringwifi = "WIFI:T:WEP;" +
//                           "P:" "${passCont.text.toString()}" +
//                           ";S:" +
//                           "${ssidCont.text.toString()}" + //REMOVE THESE EXTRA ""
//                           ";" +
//                           hiddenString;
//                     } else if (selectedType == "None") {
//                       finalStringwifi = "WIFI:T:nopass;" + //to modify
//                           "P:" +
//                           ";S:" +
//                           "${ssidCont.text.toString()}" + //REMOVE THESE EXTRA ""
//                           ";" +
//                           hiddenString;
//                     }
//                     widget.intentText.incomingTextController.sink
//                         .add(finalStringwifi.toString());
//                     Get.back();
//                   }
//                 },
//                 child: Text("Get QR")),
//           ],
//         ).paddingOnly(left: 3, right: 3),
//       ],
//     );
//   }
// }
