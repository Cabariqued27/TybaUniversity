import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tyba_university/binding/controllers.dart';
import 'package:tyba_university/flows/home/routes/home_routes.dart';
import 'package:tyba_university/i18n/translations_dictionary.dart';
import 'package:tyba_university/routes/routes.dart';
import 'package:tyba_university/system/orientation.dart';
import 'package:tyba_university/system/system_style.dart';
import 'package:tyba_university/utils/app/app_dependencies.dart';

void main() async {
  await AppDependencies.startAppDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemStyle);
    SystemChrome.setPreferredOrientations(orientation);

    return GetMaterialApp(
      title: 'Rick and Morty',
      navigatorKey: navigatorKey,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: Get.deviceLocale,
      translations: TranslationDictionary(),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: HomeRoutes().home,
      getPages: Routes().getRoutes(),
      unknownRoute: Routes().getNotFoundPage(),
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
