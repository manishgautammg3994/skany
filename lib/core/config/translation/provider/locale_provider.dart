// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../helper/l10n.dart';

// class LocaleProvider {
//   final _box = GetStorage();
//   final _key = "selectedLanguageCode";
//   // Locale? _locale;

//   String get locale => _locale;

//   void setLocale(String locale) {
//     if (!L10n.all.contains(Locale(locale))) return;

//     _locale = locale;
//     saveLocale(locale);

//     Get.updateLocale(Locale(_locale.toString()));
//   }

//   String _locale = GetStorage().read("selectedLanguageCode") ?? "en";
//   void saveLocale(String languageCode) => _box.write(_key, languageCode);

//   // bool isAutomatic = GetStorage().read("isLocaleAutomatic") ??
//   //     false; //use this to automatic set
//   // void saveSystemLocaleAutomatic(bool isAutomatic) =>
//   //     _box.write("isLocaleAutomatic", isAutomatic);

//   //   /// To be Used in very init method prior then [GetMaterialApp] only works for very First Run
//   void onlyFirstTime_oninit() async {
//     if (GetStorage().read("selectedLanguageCode") == null) {
//       String by_Default = Get.deviceLocale?.languageCode ?? "en";
//       saveLocale(by_Default);
//       // Get.updateLocale(Locale(by_Default));
//     }
//   }

//   /// Auto Selection of [Locale] on Every init to [GetMaterialApp]  works for All Time and All Property Is Defined Automatically by Device System Property
//   /// and can be used in init function with if condition taking [isAutomatic] as it is true then every time on init below  function [saveSystemLocaleAutomatic] will run
//   // void selectLocaleAutomatic() async {
//   //   String by_Default = Get.deviceLocale?.languageCode ?? "en";
//   //   saveLocale(by_Default);
//   //   Get.updateLocale(Locale(by_Default));
//   // }
// } //  Get.deviceLocale?.languageCode
