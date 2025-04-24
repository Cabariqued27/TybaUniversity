import 'package:get/get.dart';
import 'package:tyba_university/flows/home/routes/home_routes.dart';
import 'package:tyba_university/flows/settings/pages/no_found_page_flow.dart';

class Routes {
  List<GetPage<dynamic>>? getRoutes() {
    return [
      ...HomeRoutes().routes(),
    ];
  }

  getNotFoundPage() {
    String noFound = '/noFound';
    return GetPage(name: noFound, page: () => const NoFoundPageFlow());
  }
}
