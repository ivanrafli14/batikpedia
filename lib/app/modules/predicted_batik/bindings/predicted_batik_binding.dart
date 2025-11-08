import 'package:get/get.dart';

import '../controllers/predicted_batik_controller.dart';

class PredictedBatikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PredictedBatikController>(
      () => PredictedBatikController(),
    );
  }
}
