import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/modules/settings/controllers/no_found_controller.dart';
import 'package:tyba_university/widgets/responsive/responsive_widget.dart';
import 'package:tyba_university/widgets/responsive/web_frame_widget.dart';
import 'package:tyba_university/widgets/text/text_widget.dart';

class NoFoundPage extends StatelessWidget {
  final NoFoundController controller;

  const NoFoundPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: WebFrameWidget(
        child: _mobileContent(),
      ),
      tablet: WebFrameWidget(
        child: _mobileContent(),
      ),
      mobile: _mobileContent(),
    );
  }

  Widget _mobileContent() {
    return Scaffold(
      body: _pageWidget(),
      backgroundColor: controller.theme.background.value,
    );
  }

  Widget _pageWidget() {
    return Center(
      child: TextWidget(
        'No found page'.tr,
        fontFamily: AppFontFamily.workSans,
      ),
    );
  }
}
