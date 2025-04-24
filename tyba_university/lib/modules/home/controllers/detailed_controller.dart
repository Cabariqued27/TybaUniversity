import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tyba_university/preferences/user_preferences.dart';
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

  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  final emailNameInputController = TextEditingController();
  final RxString image = ''.obs;

  final _preferences = UserPreferences();
  final ImagePicker _picker = ImagePicker();

  void startController() {
    _loadImage();
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
      Get.snackbar('Permiso denegado', 'No se pudo acceder a la galería');
    }
  }

  
  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona una opción'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Seleccionar de la galería'),
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

  // Función para manejar la toma de foto o selección de imagen
  Future<void> _pickImage(ImageSource source) async {
    try {
      final fileData = await _picker.pickImage(source: source);

      if (fileData != null) {
        final file = File(fileData.path);

        universityInformation?.imagePath = file.path;
        _preferences.setImage = file.path;
        image.value = file.path;

        update();

        Get.snackbar('Éxito', 'Imagen actualizada correctamente');
      } else {
        Get.snackbar('Cancelado', 'No se seleccionó ninguna imagen');
      }
    } catch (exception, stackTrace) {
      LogError.capture(exception, stackTrace, 'onChangeProfileImage');
      Get.snackbar('Error', 'No se pudo cambiar la imagen');
    }
  }
}
