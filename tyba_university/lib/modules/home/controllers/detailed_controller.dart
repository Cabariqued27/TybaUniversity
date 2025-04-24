import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/services/models/university.dart';
import 'package:tyba_university/theme/theme.dart';

class DetailedController extends GetxController {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final AppTheme theme;
  final University? universityInformation;

  DetailedController({
    required this.onNext,
    required this.onBack,
    required this.theme,
    this.universityInformation,
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
