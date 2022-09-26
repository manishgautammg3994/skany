// import 'package:flutter/material.dart';
// import 'package:skany/app/features/home/view/components/widget/upi/threescreen/dynamic.dart';
// import 'package:skany/app/features/home/view/components/widget/upi/threescreen/merchant.dart';
// import 'package:skany/app/features/home/view/components/widget/upi/threescreen/non_merchant.dart';

// import '../../../../controller/intentlistener.dart';

// Future<void> showUPIDialog(
//     {required BuildContext context, required IntentText intentText}) async {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   return await showDialog(
//       context: context,
//       builder: (context) {
//         // var space
//         return StatefulBuilder(
//           builder: (
//             BuildContext context,
//             setState,
//           ) {
//             int tabNo = 0;

//             List<Widget> tabs = const [
//               //create your own list as such and assign to tabs:tabs
//               Tab(
//                 text: 'Non Merchant',
//               ),
//               Tab(
//                 text: 'Merchant',
//               ),
//               Tab(
//                 text: 'Dynamic',
//               ),
//             ];
//             return AlertDialog(
//               content: DefaultTabController(
//                 length: tabs.length,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TabBar(
//                       tabs: tabs,
//                       isScrollable: true,
//                       // labelColor: Colors.redAccent,
//                       // unselectedLabelColor: Colors.black,
//                       indicatorSize: TabBarIndicatorSize.label,
//                       // indicatorColor: Colors.redAccent,
//                     ),
//                     TabBarView(
//                         controller: DefaultTabController.of(context),
//                         children: [
//                           NonMerchants(
//                             onChanged: (value) {},
//                           ),
//                           Merchants(onChanged: (value) {},),
//                           DynamicUPI(onChanged: (value) {},)
//                         ] // widgets list children
//                         ),
//                   ],
//                 ),
//               ),
//               // Form(
//               //     key: formKey,
//               //     child: Column(
//               //       mainAxisSize: MainAxisSize.min,
//               //       children: [],
//               //     )),
//               actions: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     TextButton(onPressed: onPressed, child: child),
//                     TextButton(onPressed: onPressed, child: child),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       });
// }
