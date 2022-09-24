import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeViewModel {
  ///for provider use with change notifier in place of extends GetxController
  final _box = GetStorage();
  final _key = "isDarkMode";
  ThemeMode get theme => _darkMode
      ? ThemeMode.dark
      : ThemeMode
          .light; //ThemeMode.system //can be used in main getmaterial app
  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    if (_darkMode == value) {
      return;
    }
    _darkMode = value;
    saveTheme(_darkMode);
    Get.changeThemeMode(theme); //update is inbuilt
    ///for provider change to notifyListners(); and also change the extends of class to with change notifier
  }

  bool _darkMode = GetStorage().read("isDarkMode") ?? false;
  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Auto Selection of [ThemeMode] on Very init to [GetMaterialApp] only works for very First Run
  void only_first_run_oninit() async {
    if (GetStorage().read(_key) == null) {
      final default_theme = ThemeMode.system;
      if (default_theme == ThemeMode.dark) {
        saveTheme(true); //saved as dark
        Get.changeThemeMode(default_theme);
      } else {
        saveTheme(false); //saved as light
        Get.changeThemeMode(default_theme);
      }
    }
  }

  /// Auto Selection of [ThemeMode] on Every init to [GetMaterialApp]  works for All Time and All Property Is Defined Automatically by Device System Property
  /// and can be used in init function with if condition taking [_isAutomatic] as it is true then every time on init below  function [saveThemeAutomatic] will run
  bool isAutomatic = GetStorage().read("isThemeAutomatic") ?? false;
  void saveThemeAutomatic(bool isAutomatic) => _box.write(
      "isThemeAutomatic", isAutomatic); //TODO use this to set automatic
  void selectThemeAutomatic() async {
    final default_theme = ThemeMode.system;
    if (default_theme == ThemeMode.dark) {
      saveTheme(true); //saved as dark
      Get.changeThemeMode(default_theme);
    } else {
      saveTheme(false); //saved as light
      Get.changeThemeMode(default_theme);
    }
  }
}
/////////////////////////////USELESS CODE//////////////////
// class LocaleManagement extends Translations {
//   final _box = GetStorage();
//   final _key = "language";
//   String selectedLocale = 'en'; //TODO Change This
//   final locale = Locale('en', 'US');
//   final fallbackLocale = const Locale('en', 'US');
//   static final Langs = LanguagesList().languages;
//   static final locales = [
//     Locale('en', 'US'),
//     Locale('en', 'US'),
//     Locale('en', 'US')
//   ];

//   String get localeee => _localeee;
//   set localeee(String languageCode) {
//     if (_localeee == languageCode) {
//       return;
//     } else {
//       var localez = _getLocaleFromLanguagesCode(languageCode);

//       _localeee = languageCode;
//       Get.updateLocale(localez);
//       // Get.updateLocale(Locale(_localeee, '')); //update is inbuilt
//       ///for provider change to notifyListners(); and also change the extends of class to with change notifier
//     }
//   }

//   String _localeee = GetStorage().read("language") ?? 'en';
//   void saveLocale(String languageCode) => _box.write(_key, languageCode);

//   Locale _getLocaleFromLanguagesCode(String languageCode) {
//     late Locale? locale; // = Get.locale!;
//     for (var i = 0; i < Langs.length; i++) {
//       if (languageCode == Langs[i].code) {
//         Langs[i].selected = true;
//         locale = locales[i];
//       } else {
//         Langs[i].selected = false;
//         locale = Get.locale!; //else case}
//       }
//     }
//     return locale ?? Get.locale!;
//   }

//   @override
//   // TODO: implement keys
//   Map<String, Map<String, String>> get keys => {
//         'en_US': en,
//         'ar_AR': ar,
//       };
//   //throw UnimplementedError();
// }
