import 'package:get/get.dart';

import '../controller/home_controller.dart'; 

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    // Get.put(() => HomeController());
  }
}
// Get.delete()