import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1108226064694972/8014842618"; // todo add this
    }
    // else if (Platform.isIOS) {
    //   return ""; //please first configure for ios then add
    // }
    return throw new UnsupportedError("Unsupported platform");
    ;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) {
      debugPrint("ads loaded");
    },
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("ads load error");
    },
    onAdOpened: (ad) {
      debugPrint("add opened");
    },
    onAdClosed: (ad) {
      debugPrint("add closed");
    },
  );
}
