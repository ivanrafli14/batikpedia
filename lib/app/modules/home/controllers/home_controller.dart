import 'package:batikpedia/app/data/batik_model.dart';
import 'package:batikpedia/app/data/city_model.dart';
import 'package:batikpedia/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:batikpedia/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:batikpedia/app/routes/app_pages.dart';
import 'package:batikpedia/app/services/supabase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final SupabaseService _supabaseService = SupabaseService();

  final carouselIndex = 0.obs;
  final isLoading = false.obs;
  final batikItems = <BatikModel>[].obs;
  final cities = <CityModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadData() async{
    try {
      isLoading.value = true;


      final batikData = await _supabaseService.loadBatik();
      final citiesData = await _supabaseService.loadCity();

      print(batikData);

      batikItems.value = batikData;
      cities.value = citiesData;
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to load data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onBatikItemPressed(BatikModel item) {
    Get.toNamed(Routes.DETAIL_BATIK, arguments: {'id': item.id});
  }

  void onCityPressed(CityModel city) {
    final navbarController = Get.find<NavbarController>();
    navbarController.changeTab(1);

    final galleryController = Get.find<GalleryController>();
    galleryController.selectedFilters.value = [city.name];
    galleryController.refreshData();

  }


  void onCarouselChanged(int index) {
    carouselIndex.value = index;
  }

  void onDiscoverMorePressed() {
    final navbarController = Get.find<NavbarController>();
    navbarController.changeTab(1);
    Get.find<GalleryController>().selectedFilters.assign('All');
  }

  String optimizeCloudinaryUrl(String url, {int width = 600, int quality = 70}) {
    if (!url.contains('/upload/')) return url;
    return url.replaceFirst(
      '/upload/',
      '/upload/f_auto,q_auto,w_$width,q_$quality/',
    );
  }

}
