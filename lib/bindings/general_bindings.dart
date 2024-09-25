import 'package:get/get.dart';

import '../business_logics/controllers/meme_controller.dart';
import '../business_logics/controllers/meme_details_page_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MemeController());
    Get.put(MemeDetailsController());
  }
}
