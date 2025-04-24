import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/modules/home/controllers/home_controller.dart';
import 'package:tyba_university/modules/home/pages/home_page.dart';
import 'package:tyba_university/theme/theme.dart';

class HomePageFlow extends StatefulWidget {
  const HomePageFlow({super.key});

  @override
  State<HomePageFlow> createState() => _HomePageFlowState();
}

class _HomePageFlowState extends State<HomePageFlow> {
  late HomeController _controller;
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = HomeController(
      theme: _theme,
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      controller: _controller,
    );
  }
}
