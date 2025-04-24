import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyba_university/enums/preferences_enum.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //IMAGE

  String getImage() => _prefs.getString(PreferencesEnum.image) ?? '';
  set setImage(String value) => _prefs.setString(PreferencesEnum.image, value);

  //CAMERA PERMISSION

  bool getCamera() => _prefs.getBool(PreferencesEnum.camera) ?? false;
  set setCamera(bool value) => _prefs.setBool(PreferencesEnum.camera, value);

  //PHOTOS PERMISSION

  bool getPhotos() => _prefs.getBool(PreferencesEnum.photos) ?? false;
  set setPhotos(bool value) => _prefs.setBool(PreferencesEnum.photos, value);

  void deleteAllData() {
    _prefs.setBool(PreferencesEnum.camera, false);
    _prefs.setBool(PreferencesEnum.photos, false);
    _prefs.setString(PreferencesEnum.image, '');
  }
}
