import 'dart:async';

class IntentImage {
//   IntentImage() {
//  }

  String? imagePath;

  StreamController<String?> incomingImageController =
      StreamController<String?>.broadcast();
  Stream<String?> get imagePathStream =>
      incomingImageController.stream.asBroadcastStream();
}

class IntentText {
//   IntentText() {
//  }

  String? intentText;

  StreamController<String?> incomingTextController =
      StreamController<String?>.broadcast();
  Stream<String?> get textStream => incomingTextController.stream;
}
