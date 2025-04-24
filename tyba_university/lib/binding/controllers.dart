import 'package:tyba_university/flows/home/controllers/home_flow.dart';
import 'package:tyba_university/theme/theme.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AppTheme(),
      permanent: true,
    );
    Get.put(
      HomeFlow(),
      permanent: true,
    );
  }
}
