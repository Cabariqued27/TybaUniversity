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
  var isGridView = false.obs;
  final universities = <University>[].obs;
  final _apiService = ApiProvider();
  final ScrollController scrollController = ScrollController();
  final PaginationController paginationController = PaginationController();

  void startController() async {
    await loadUniversities(isInitial: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !paginationController.isFetchingMore.value &&
          paginationController.hasMore.value) {
        loadUniversities();
      }
    });
    updateLoadData(true);
  }

  void updateLoadData(bool value) {
    isLoadData.value = value;
  }

  void showUniversity(University item) {
    onNext(item);
  }

  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  Future<void> loadUniversities({bool isInitial = false}) async {
    List<University> fetched = await paginationController.loadPage(_apiService);

    if (fetched.isEmpty) return;

    if (isInitial) {
      universities.assignAll(fetched);
    } else {
      universities.addAll(fetched);
    }
  }
}

class PaginationController extends GetxController {
  var isFetchingMore = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;

  Future<List<University>> loadPage(ApiProvider apiService) async {
    if (isFetchingMore.value || !hasMore.value) return [];

    isFetchingMore.value = true;
    try {
      final fetched = await apiService.fetchUniversities(page: page.value);
      if (fetched.isEmpty || fetched.length < 20) {
        hasMore.value = false;
      }
      page.value++;
      return fetched;
    } catch (e) {
      Get.snackbar('error.tr', 'Ha ocurrido un error al cargar las universidades.');
      return [];
    } finally {
      isFetchingMore.value = false;
    }
  }
}
