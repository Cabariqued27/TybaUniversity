import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/services/models/university.dart';
import 'package:tyba_university/services/providers/api_provider.dart';
import 'package:tyba_university/theme/theme.dart';

class HomeController extends GetxController {
  final AppTheme theme;
  final Function(University) onNext;

  HomeController({
    required this.onNext,
    required this.theme,
  });

  final searchController = TextEditingController();

  var isLoadData = false.obs;
  var isFetchingMore = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;

  final universities = <University>[].obs;
  final _apiService = ApiProvider();
  final ScrollController scrollController = ScrollController();


  void startController() async {
    await loadUniversities(isInitial: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        loadUniversities();
      }
    });
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
    update();
  }

  void showUniversity(University item) {
    onNext(item);
  }

  var isGridView = false.obs;

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  Future<void> loadUniversities({bool isInitial = false}) async {
    if (isFetchingMore.value || !hasMore.value) return;

    isFetchingMore.value = true;

    try {
      final fetched = await _apiService.fetchUniversities(page: page.value);

      if (fetched.isEmpty || fetched.length < 20) {
        hasMore.value = false;
      }

      if (isInitial) {
        universities.assignAll(fetched);
      } else {
        universities.addAll(fetched);
      }

      page.value++;
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isFetchingMore.value = false;
    }
  }
}
