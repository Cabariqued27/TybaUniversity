import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/flows/home/controllers/home_flow.dart';
import 'package:tyba_university/modules/home/controllers/detailed_controller.dart';
import 'package:tyba_university/modules/home/pages/detailed_page.dart';
import 'package:tyba_university/theme/theme.dart';

class DetailedPageFlow extends StatefulWidget {
  const DetailedPageFlow({super.key});

  @override
  State<DetailedPageFlow> createState() => _DetailedPageFlowState();
}

class _DetailedPageFlowState extends State<DetailedPageFlow> {
  late DetailedController _controller;
  final _theme = Get.find<AppTheme>();
  final _homeFlow = Get.find<HomeFlow>();

  @override
  void initState() {
    super.initState();
    _controller = DetailedController(
      theme: _theme,
      universityInformation: _homeFlow.getUniversity(),
      onNext: () {
        _homeFlow.deleteAllData();
        _homeFlow.start();
      },
      onBack: () {
        _homeFlow.deleteAllData();
        Get.back();
      },
    );

    _controller.startController();
  }

  @override
  Widget build(BuildContext context) {
    return DetailedPage(
      controller: _controller,
    );
  }
}
