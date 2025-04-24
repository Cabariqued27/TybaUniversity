import 'package:get/get.dart';
import 'package:tyba_university/flows/home/pages/detailed_page_flow.dart';
import 'package:tyba_university/flows/home/pages/home_page_flow.dart';

class HomeRoutes {
  
  String home = '/home';
  String detail = '/detail';

  List<GetPage<dynamic>> routes() {
    return [
      
      GetPage(
        name: home,
        page: () => const HomePageFlow(),
      ),
      GetPage(
        name: detail,
        page: () => const DetailedPageFlow(),
      ),
      
    ];
  }
}
