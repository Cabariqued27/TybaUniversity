import 'package:get/get.dart';
import 'package:tyba_university/flows/home/routes/home_routes.dart';
import 'package:tyba_university/services/models/university.dart';

class HomeFlow extends GetxController {
  University? _university;

  void start() {
    Get.offAllNamed(HomeRoutes().home);
  }

  void startOffNamed() {
    Get.offNamed(HomeRoutes().home);
    return;
  }

  University? getUniversity() {
    return _university;
  }

  void setUniversity(University? value) {
    _university = value;
  }

  void finish() {
    deleteAllData();
  }

  void deleteAllData() {
    _university = null;
  }
}
