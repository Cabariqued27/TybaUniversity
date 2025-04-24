import 'package:flutter/material.dart';


class AppDependencies {
  static Future<void> startAppDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    //AppSetting().startEnv();
    //await startFirebase();
    //await UserPreferences().initPrefs();
    //await SupabaseConnection().startConexion();

  }

 

}
