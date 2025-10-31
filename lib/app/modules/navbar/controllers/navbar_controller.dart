import 'package:get/get.dart';

class NavbarController extends GetxController {
  //TODO: Implement NavbarController

  var currentTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['startTab'] != null) {
      currentTab.value = args['startTab'];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTab(int index){
    currentTab.value = index;
  }
}
