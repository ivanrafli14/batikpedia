import 'package:get/get.dart';

import '../controllers/generate_batik_controller.dart';

class GenerateBatikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateBatikController>(
      () => GenerateBatikController(),
    );
  }
}
