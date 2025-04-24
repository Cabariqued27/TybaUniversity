import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyba_university/modules/home/controllers/home_controller.dart';
import 'package:tyba_university/services/models/university.dart';
import 'package:tyba_university/utils/app/app_margin.dart';
import 'package:tyba_university/utils/app/app_size.dart';
import 'package:tyba_university/widgets/loading/loading_data_widget.dart';
import 'package:tyba_university/widgets/responsive/responsive_widget.dart';
import 'package:tyba_university/widgets/responsive/web_frame_widget.dart';
import 'package:tyba_university/widgets/text/text_widget.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;

  const HomePage({
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
          SafeArea(
            child: Container(
              width: AppSize.width(),
              height: AppSize.height(),
              margin: EdgeInsets.symmetric(
                vertical: AppMargin.vertical(),
                horizontal: AppMargin.horizontal(),
              ),
              child: (controller.isLoadData.value)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _toogle(),
                        SizedBox(height: AppSize.width() * 0.03),
                        _universitiesListWidget()
                      ],
                    )
                  : LoadingDataWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toogle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            controller.isGridView.value ? Icons.view_list : Icons.grid_view,
            color: controller.theme.black.value,
          ),
          onPressed: controller.toggleViewMode,
        ),
      ],
    );
  }

  Widget _universitiesListWidget() {
    final universities = controller.universities;
    final isGrid = controller.isGridView.value;
    final hasMore = controller.paginationController.hasMore.value; 

    Widget buildListItem(int index) {
      if (index < universities.length) {
        return isGrid
            ? FadeIn(
                duration: Duration(milliseconds: 300 + index * 50),
                child: _universityItemGridWidget(universities[index]),
              )
            : SlideInUp(
                duration: Duration(milliseconds: 300 + index * 50),
                child: _universityItemWidget(universities[index]),
              );
      } else {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }
    }

    Widget buildGridView() {
      return GridView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.only(bottom: AppMargin.vertical() * 2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3,
        ),
        itemCount: universities.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) => buildListItem(index),
      );
    }

    Widget buildListView() {
      return ListView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.only(bottom: AppMargin.vertical() * 2),
        itemCount: universities.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) => buildListItem(index),
      );
    }

    return Expanded(
      child: isGrid ? buildGridView() : buildListView(),
    );
  }

  Widget _universityItemWidget(University university) {
    return InkWell(
      onTap: () => controller.showUniversity(university),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppMargin.vertical(),
          horizontal: AppMargin.horizontal(),
        ),
        child: Container(
          padding: EdgeInsets.all(AppMargin.vertical()),
          decoration: BoxDecoration(
            color: controller.theme.white.value,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                university.name,
                fontFamily: AppFontFamily.leagueSpartan,
                fontWeight: TextWidgetWeight.bold,
                dsize: RelSize(size: TextWidgetSizes.xxsmall),
                color: controller.theme.black.value,
              ),
              const SizedBox(height: 4),
              TextWidget(
                university.country,
                fontFamily: AppFontFamily.leagueSpartan,
                dsize: RelSize(size: TextWidgetSizes.xxsmall),
                color: controller.theme.black.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _universityItemGridWidget(University university) {
    return InkWell(
      onTap: () => controller.showUniversity(university),
      child: Container(
        padding: EdgeInsets.only(top: AppMargin.vertical()),
        height: AppSize.width() * 0.1,
        decoration: BoxDecoration(
          color: controller.theme.white.value,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              university.name,
              fontFamily: AppFontFamily.leagueSpartan,
              fontWeight: TextWidgetWeight.bold,
              dsize: RelSize(size: TextWidgetSizes.xxsmall),
              color: controller.theme.black.value,
              textAlign: TextAlign.center,
            ),
            TextWidget(
              university.country,
              fontFamily: AppFontFamily.leagueSpartan,
              dsize: RelSize(size: TextWidgetSizes.xxsmall),
              color: controller.theme.black.value,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
