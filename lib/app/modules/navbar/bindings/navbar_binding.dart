import 'package:batikpedia/app/modules/about/controllers/about_controller.dart';
import 'package:batikpedia/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:batikpedia/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GalleryController>(() => GalleryController());
    Get.lazyPut<AboutController>(() => AboutController());
  }
}
