import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/theme/theme.dart';

class DetailedController extends GetxController {
  final AppTheme theme;

  DetailedController({
    required this.theme,
  });

  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  final emailNameInputController = TextEditingController();

  void startController() {
    loadingData();
    loadingRegisterAt();
  }

  void loadingData() {
    update();
  }

  Future<void> loadingRegisterAt() async {}
}
