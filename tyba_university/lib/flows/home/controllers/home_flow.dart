import 'package:get/get.dart';
import 'package:tyba_university/flows/home/routes/home_routes.dart';

class HomeFlow extends GetxController {
  void start() {
    Get.offAllNamed(HomeRoutes().home);
  }

  void startOffNamed() {
    Get.offNamed(HomeRoutes().home);
    return;
  }
}
