import 'package:get_storage/get_storage.dart';

class CustomUrl {
  final _box = GetStorage();
  final _key = "customUrl";

  String? get customurl => _customurl;
  set customurl(String? value) {
    if (_customurl == value) {
      return;
    }
    _customurl = value;
    saveTheme(_customurl);

    ///for provider change to notifyListners(); and also change the extends of class to with change notifier
  }

  String? _customurl =
      GetStorage().read("customUrl") ?? "https://www.google.com/search?q=";
  void saveTheme(String? customurl) => _box.write(_key, customurl);
}
