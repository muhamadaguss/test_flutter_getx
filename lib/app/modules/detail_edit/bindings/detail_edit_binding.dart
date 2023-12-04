import 'package:get/get.dart';

import '../controllers/detail_edit_controller.dart';

class DetailEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailEditController>(
      () => DetailEditController(),
    );
  }
}
