import 'package:get/get.dart';

import '../controllers/detect_batik_controller.dart';

class DetectBatikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetectBatikController>(
      () => DetectBatikController(),
    );
  }
}
