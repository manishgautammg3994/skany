// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../service/servicelocator.dart';
// import '../../provider/locale_provider.dart';
// import '../l10n.dart';

// // class LanguageWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final locale = Get.locale; // or  Localizations.localeOf(context);
// //     final flag = L10n.getFlag(locale!.languageCode);

// //     return Center(
// //       child: CircleAvatar(
// //         backgroundColor: Colors.white,
// //         radius: 12,
// //         child: Text(
// //           flag,
// //           style: TextStyle(fontSize: 80),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class LanguagePickerWidget extends StatefulWidget {
//   const LanguagePickerWidget({super.key});

//   //provider
//   static LocaleProvider get provider => ServiceLocator.get<LocaleProvider>();

//   @override
//   State<LanguagePickerWidget> createState() => _LanguagePickerWidgetState();
// }

// class _LanguagePickerWidgetState extends State<LanguagePickerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final locale = LanguagePickerWidget.provider;

//     return DropdownButtonHideUnderline(
//       child: DropdownButton<Locale>(
//         value: Locale(locale.locale),
//         icon: Container(width: 12),
//         items: L10n.all.map(
//           (Locale locale) {
//             final flag = L10n.getFlag(locale.languageCode);

//             return DropdownMenuItem(
//               value: locale,
//               child: Center(
//                 child: Text(
//                   flag,
//                   style: TextStyle(fontSize: 32),
//                 ),
//               ),
//               // onTap: () {
//               //   // final provider = Provider.of<LocaleProvider>(context, listen: false);

//               //   LanguagePickerWidget.provider.setLocale(locale.countryCode!);
//               // },
//             );
//           },
//         ).toList(),
//         onChanged: (value) async {
//           setState(() {
//             LanguagePickerWidget.provider.setLocale(value!.languageCode);
//           });
//         },
//       ),
//     );
//   }
// }
