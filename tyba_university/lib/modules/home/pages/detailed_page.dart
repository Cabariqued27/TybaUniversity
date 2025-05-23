import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tyba_university/modules/home/controllers/detailed_controller.dart';
import 'package:tyba_university/services/models/university.dart';
import 'package:tyba_university/utils/app/app_margin.dart';
import 'package:tyba_university/utils/app/app_size.dart';
import 'package:tyba_university/widgets/buttons/single_button_widget.dart';
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
      desktop: WebFrameWidget(child: _mobileContent()),
      tablet: WebFrameWidget(child: _mobileContent()),
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
                _universityInformationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _universityInformationWidget() {
    final info = controller.universityInformation;

    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          _universityName(info),
          _universityImage(info),
          SizedBox(height: AppSize.width()*0.01),
          _uploadButton(),
           SizedBox(height: AppSize.width()*0.01),
          _universityDetails(info),
        ],
      ),
    );
  }

 
  Widget _universityName(University? info) {
    return TextWidget(
      info?.name ?? '',
      fontFamily: AppFontFamily.leagueSpartan,
      fontWeight: FontWeight.w600,
      dsize: RelSize(size: TextWidgetSizes.normal),
      color: controller.theme.black.value,
      textAlign: TextAlign.center,
    );
  }


  Widget _universityImage(University? info) {
    return SizedBox(
      height: AppSize.height() * 0.1,
      child: controller.image.value.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(controller.image.value),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.image, size: 100, color: Colors.grey),
    );
  }


  Widget _uploadButton() {
    return SizedBox(
      height: AppSize.height() * 0.05,
      child: ElevatedButton.icon(
        onPressed: controller.validatePhotosPermission,
        icon: const Icon(Icons.upload_file),
        label: Text("upload_image".tr),
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.theme.primary.value,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

 
  Widget _universityDetails(University? info) {
    return Column(
      children: [
        _infoText("country".tr, info?.country),
        _infoText("state_province".tr, info?.stateProvince),
        _infoText("domains".tr, info?.domains.join(", ")),
        _infoText("web_pages".tr, info?.webPages.join(", ")),
        _studentCountInput(),
      ],
    );
  }

 
  Widget _infoText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value ?? "not_available".tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _studentCountInput() {
    return Column(
      children: [
        SizedBox(height: AppSize.height() * 0.01),
        TextWidget(
          "number_of_students".tr,
          fontFamily: AppFontFamily.workSans,
        ),
        TextField(
          controller: controller.studentCountController,
          keyboardType: TextInputType.number,
          onChanged: controller.onStudentCountChanged,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "ej_15000".tr,
          ),
        ),
        SizedBox(height: AppSize.height() * 0.01),
        SingleButtonWidget(
          onPressed: controller.saveStudentCount,
          title: "save".tr,
          isActive: controller.isStudentCountValid.value,
          backgroundColor: controller.theme.primary.value,
          textColor: controller.theme.white.value,
          fontFamily: AppFontFamily.workSans,
          height: AppSize.width() * 0.1,
          width: AppSize.width() * 0.5,
        ),
      ],
    );
  }
}
