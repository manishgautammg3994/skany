
import '../config/theme/helper/themeviewmodel.dart';
import '../config/translation/provider/locale_provider.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  //or use GetxService for better response
  static init() {
    getIt.registerSingleton<ThemeViewModel>(ThemeViewModel());
    getIt.registerSingleton<LocaleProvider>(LocaleProvider());
  }

  static T get<T extends Object>() {
    return getIt.get<T>();
  }
}
//LocaleProvider GradeSelected