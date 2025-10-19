import 'package:batikpedia/app/data/detail_batik_model.dart';
import 'package:batikpedia/app/services/supabase_service.dart';
import 'package:get/get.dart';

class DetailBatikController extends GetxController {
  //TODO: Implement DetailBatikController
  final batikDetail = Rxn<DetailBatikModel>();
  final isLoading = false.obs;
  final _supabaseService = SupabaseService();

  @override
  void onInit() {
    super.onInit();
    final batikId = Get.arguments['id'];
    fetchDetailBatik(batikId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchDetailBatik(int id) async {
    try {
      isLoading.value = true;
      final detailBatik = await _supabaseService.loadDetailBatik(id);
      batikDetail.value = detailBatik;
      print(detailBatik);
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to load detail data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }


}
