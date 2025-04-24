import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tyba_university/services/models/university.dart';
import 'package:tyba_university/theme/theme.dart';
import 'package:tyba_university/utils/global/log_error_utils.dart';

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

  final studentCountController = TextEditingController();
  final RxString image = ''.obs;

  final ImagePicker _picker = ImagePicker();

  void startController() {
    _loadImage();
    _loadStudent();
  }

  void _loadStudent() {
    if (universityInformation?.studentCount != null) {
      studentCountController.text =
          universityInformation!.studentCount.toString();
    }
  }

  void _loadImage() {
    String savedImagePath = universityInformation?.imagePath ?? '';
    if (savedImagePath.isNotEmpty) {
      image.value = savedImagePath;
    }
  }

  Future<void> validatePhotosPermission() async {
    try {
      await _showImagePickerDialog();
    } catch (e, stack) {
      LogError.capture(e, stack, 'validatePhotosPermission');
      Get.snackbar('permission_denied'.tr, 'could_not_access_gallery'.tr);
    }
  }

  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('select_an_option'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('take_photo'.tr),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text('choose_from_gallery'.tr),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final fileData = await _picker.pickImage(source: source);

      if (fileData != null) {
        final file = File(fileData.path);

        universityInformation?.imagePath = file.path;

        image.value = file.path;

        update();

        Get.snackbar('success'.tr, 'image_updated_successfully'.tr);
      } else {
        Get.snackbar('cancelled'.tr, 'no_image_selected'.tr);
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, '_pickImage');
      Get.snackbar('error'.tr, 'could_not_change_image'.tr);
    }
  }

  void saveStudentCount() {
    final input = studentCountController.text.trim();
    if (input.isEmpty) {
      Get.snackbar('required_field'.tr, 'please_enter_a_student_number'.tr);
      return;
    }

    final parsed = int.tryParse(input);
    if (parsed == null || parsed <= 0) {
      Get.snackbar(
          'invalid_value'.tr, 'enter_a_valid_number_greater_than_zero'.tr);
      return;
    }

    universityInformation?.studentCount = parsed;
    Get.snackbar('saved'.tr, 'student_number_updated'.tr);
  }
}
