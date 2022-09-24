import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '/core/config/routes/app_pages.dart';

import 'app/features/home/binding/home_binding.dart';
import 'app/features/home/view/home_view.dart';
import 'core/config/theme/app_basic_theme.dart';
import 'core/config/theme/helper/themeviewmodel.dart';
import 'core/config/translation/helper/l10n.dart';
import 'core/config/translation/messages.dart';
import 'core/config/translation/provider/locale_provider.dart';
import 'core/service/servicelocator.dart';
import 'dymmymain.dart';

void main() async {
  await GetStorage.init();
  ServiceLocator
      .init(); // even you can prefer getxservices for singolton dependecy injection but in that case you have to call that after   WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription? _intentDataStreamSubscription;
  List<SharedMediaFile?>? _sharedFiles;
  String? _sharedText;
  static ThemeViewModel get themeService =>
      ServiceLocator.get<ThemeViewModel>();
  static LocaleProvider get localeService =>
      ServiceLocator.get<LocaleProvider>();
  // This widget is the root of your application. LocaleProvider
  @override
  void initState() {
    //advanced design for theme management and locale management
    super.initState();
    themeService.only_first_run_oninit();
    if (themeService.isAutomatic) {
      themeService.selectThemeAutomatic();
    }
    localeService.onlyFirstTime_oninit();
    // if (localeService.isAutomatic) {
    //   localeService.selectLocaleAutomatic();
    // }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // For sharing images coming from outside the app while the app is in the memory
    Future.delayed(Duration(seconds: 1)).then((value) {
      _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
          .listen((List<SharedMediaFile> value) {
        if (value[0].path.trim() != "" ) {
          Get.offAll(
              () => HomePage(
                    incomingImage: value[0].path.toString(),
                  ),
              arguments: {'incomingImage': value[0].path});
        }
      }, onError: (err) {
        print("getIntentDataStream error: $err");
      });

      // For sharing images coming from outside the app while the app is closed
      ReceiveSharingIntent.getInitialMedia()
          .then((List<SharedMediaFile> value) {
        if (value[0].path.trim() != "") {
          Get.offAll(() => HomePage(incomingImage: value[0].path.trim().toString()),
              arguments: {'incomingImage': value[0].path.trim().toString()});
        }
      });

      // For sharing or opening urls/text coming from outside the app while the app is in the memory
      _intentDataStreamSubscription =
          ReceiveSharingIntent.getTextStream().listen((String? value) {
        if (value != null && value != "") {
          Get.offAll(() => HomePage(incomingText: value.toString()),
              arguments: {'incomingText': value.toString()});
        }
      }, onError: (err) {
        print("getLinkStream error: $err");
      });

      // For sharing or opening urls/text coming from outside the app while the app is closed
      ReceiveSharingIntent.getInitialText().then((String? value) {
        if (value != null && value != "") {
          Get.offAll(() => HomePage(incomingText: value.toString()),
              arguments: {'incomingText': value.toString()});
        }
      });
    });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }

  @override
  void dispose() {
    super.dispose();
    _intentDataStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //even Getx is not required but for simplification we used that
      title: 'Kids Learning', //Change if YOU like
      debugShowCheckedModeBanner: false,
      theme: AppBasicTheme.getThemeDataLight(),
      darkTheme: AppBasicTheme.getThemeDataDark(),
      themeMode: themeService.theme,
      translations: Messages(),
      locale: Locale(localeService.locale),
      supportedLocales: L10n.all,
      fallbackLocale: const Locale('en'),
      routingCallback: (route) {
        debugPrint(route?.previous.toString());
        debugPrint(route?.current.toString());
        if (route?.previous == "your route name path" &&
            route?.current == "when the current route") {
          debugPrint("show ads");
        }
      },
      // builder: (context, child) => ResponsiveWrapper.builder(
      //   child,
      //   maxWidth: 1200,
      //   minWidth: 480,
      //   defaultScale: true,
      //   breakpoints: [
      //     const ResponsiveBreakpoint.resize(480, name: MOBILE),
      //     const ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //     const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      //   ],
      // ),
      // getPages: AppPages.routes,
      // initialRoute: AppPages.initial,
// home: MyAppz(),
      // localizationsDelegates: [ // TODO add yourselef if you can or leave it
      //    // AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      home: HomePage(),
      initialBinding: HomeBinding(),
    );
  }
}
