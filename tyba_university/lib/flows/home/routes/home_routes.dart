import 'package:get/get.dart';
import 'package:tyba_university/flows/home/pages/home_page_flow.dart';

class HomeRoutes {
  
  String home = '/home';

  List<GetPage<dynamic>> routes() {
    return [
      
      GetPage(
        name: home,
        page: () => const HomePageFlow(),
      ),
      
    ];
  }
}
