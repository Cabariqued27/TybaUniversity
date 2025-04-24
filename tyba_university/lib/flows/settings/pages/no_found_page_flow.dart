import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/modules/settings/controllers/no_found_controller.dart';
import 'package:tyba_university/modules/settings/pages/no_found_page.dart';
import 'package:tyba_university/theme/theme.dart';

class NoFoundPageFlow extends StatefulWidget {
  const NoFoundPageFlow({super.key});

  @override
  State<NoFoundPageFlow> createState() => _NoFoundPageFlowState();
}

class _NoFoundPageFlowState extends State<NoFoundPageFlow> {
  late NoFoundController _controller;
  final _theme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
    _controller = NoFoundController(
      theme: _theme,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NoFoundPage(
      controller: _controller,
    );
  }
}
