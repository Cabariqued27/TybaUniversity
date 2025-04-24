import 'package:flutter/material.dart';
import 'package:tyba_university/preferences/user_preferences.dart';


class AppDependencies {
  static Future<void> startAppDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    //AppSetting().startEnv();
    //await startFirebase();
    await UserPreferences().initPrefs();
    //await SupabaseConnection().startConexion();

  }

 

}
