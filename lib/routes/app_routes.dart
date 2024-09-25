
import 'package:get/get.dart';
import 'package:memes/routes/routes.dart';

import '../presentation/screens/meme_details_screen.dart';
import '../presentation/screens/meme_list_screen.dart';

class AppRoutes {
  static final pages = [

    GetPage(name: RouteStrings.memeList, page: () =>  MemeListScreen()),
    GetPage(name: RouteStrings.memeDetails, page: () =>  MemeDetailScreen()),
  ];
}
