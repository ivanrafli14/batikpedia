import 'package:batikpedia/app/data/batik_model.dart';
import 'package:batikpedia/app/data/city_model.dart';
import 'package:batikpedia/app/routes/app_pages.dart';
import 'package:batikpedia/app/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  //TODO: Implement GalleryController

  var batikItems = <BatikModel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  final limit = 6;

  final cityFilters = <String>[].obs;
  final selectedFilters = <String>[].obs;
  var showFilters = false.obs;

  var searchQuery = ''.obs;
  final scrollController = ScrollController();

  var _supabaseService = SupabaseService();

  @override
  void onInit() {
    super.onInit();

    fetchBatik();
    fetchCity();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          hasMore.value) {
        fetchBatik();
      }
    });

    debounce(searchQuery, (_) {
      refreshData(); // reload ketika search berubah
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();

  }

  Future<void> fetchBatik() async {
    if(isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    try {
      var newBatikItems = await _supabaseService.loadBatik(
        page: page.value,
        limit: limit,
        searchQuery: searchQuery.value.isEmpty ? null : searchQuery.value,
        filteredCities: selectedFilters.isEmpty ? null : selectedFilters.toList(),
      );

      if (newBatikItems.length < limit) {
        hasMore.value = false;

      }
      batikItems.addAll(newBatikItems);
      page.value += 1;

    } catch (e) {
      print('Error fetchBatik: $e');
    } finally {
      isLoading.value = false;
    }

  }

  Future<void> refreshData() async {
    page.value = 1;
    hasMore.value = true;
    batikItems.clear();
    await fetchBatik();
  }

  Future<void> fetchCity() async {
    var response = await _supabaseService.loadCity();
    cityFilters.value = response.map((city) => city.name).toList();

  }

  void onSearchChanged(String value) {
    searchQuery.value = value.trim();
  }

  void goToDetailPage(int batikId) {
    Get.toNamed(
      Routes.DETAIL_BATIK,
      arguments: {'id': batikId},
    );
  }

  String optimizeCloudinaryUrl(String url, {int width = 600, int quality = 70}) {
    if (url.isEmpty || !url.contains('/upload/')) return url;

    return url.replaceFirst(
      '/upload/',
      '/upload/f_auto,q_auto,w_$width,q_$quality/',
    );
  }
}
