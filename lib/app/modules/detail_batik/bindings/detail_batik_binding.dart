import 'package:get/get.dart';

import '../controllers/detail_batik_controller.dart';

class DetailBatikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBatikController>(
      () => DetailBatikController(),
    );
  }
}
