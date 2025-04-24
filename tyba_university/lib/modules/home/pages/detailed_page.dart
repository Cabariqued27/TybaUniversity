import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/modules/home/controllers/detailed_controller.dart';
import 'package:tyba_university/utils/app/app_margin.dart';
import 'package:tyba_university/utils/app/app_size.dart';
import 'package:tyba_university/widgets/responsive/responsive_widget.dart';
import 'package:tyba_university/widgets/responsive/web_frame_widget.dart';
import 'package:tyba_university/widgets/text/text_widget.dart';

class DetailedPage extends StatelessWidget {
  final DetailedController controller;

  const DetailedPage({
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
    return Obx(
      () => Scaffold(
        body: _pageWidget(),
        backgroundColor: controller.theme.background.value,
      ),
    );
  }

  Widget _pageWidget() {
    return SizedBox(
      width: AppSize.width(),
      height: AppSize.height(),
      child: Stack(
        children: [
          Container(
            width: AppSize.width(),
            height: AppSize.height(),
            margin: EdgeInsets.symmetric(
              vertical: AppMargin.vertical(),
              horizontal: AppMargin.horizontal(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.width() * 0.15),
                _userInformationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInformationWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          TextWidget(
            '${controller.universityInformation?.name} ',
            fontFamily: AppFontFamily.leagueSpartan,
            fontWeight: FontWeight.w600,
            dsize: RelSize(size: TextWidgetSizes.normal),
            color: controller.theme.black.value,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
