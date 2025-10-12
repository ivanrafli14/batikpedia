import 'package:batikpedia/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

 void navigateToNavbar(){
    Get.offAndToNamed(Routes.NAVBAR);
 }
}
