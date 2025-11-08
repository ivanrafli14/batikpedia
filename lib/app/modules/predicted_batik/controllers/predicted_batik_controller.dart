import 'dart:io';

import 'package:batikpedia/app/data/prediction_response.dart';
import 'package:batikpedia/app/services/ai_service.dart';
import 'package:get/get.dart';

class PredictedBatikController extends GetxController {
  //TODO: Implement PredictedBatikController
  final AiService _aiService = AiService();
  final isLoading = false.obs;
  final aiResult = Rx<PredictionResponse?>(null);
  final imagePath = ''.obs;

  void loadDummyResult() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // simulasi loading

    aiResult.value = PredictionResponse.fromJson({
      "predicted_batik": "Mak-mak Mbois",
      "similarity_score": 0.32911449670791626,
      "description":
      "Based on the uploaded image and the detected motif 'Mak-mak Mbois', here's a description of a possible batik pattern:\n\n"
          "This batik pattern would be a lively and contemporary design, drawing inspiration directly from the cheerful, energetic female figure in the drawing. "
          "The motif 'Mak-mak Mbois' (which translates to 'Cool Moms/Women') perfectly encapsulates the spirit of this design, reflecting a modern, confident, and stylish woman.\n\n"
          "**Possible Batik Pattern Description:**\n\n"
          "1.  **Main Motif (Central Figure):** The centerpiece would be a stylized depiction of a vibrant woman, inspired by the girl in the image. "
          "Rendered with clean, flowing batik lines, her posture would convey dynamic energy and self-assurance.\n\n"
          "2.  **Secondary Motifs:** Floating hearts, geometric accents, and floral details symbolizing joy, love, and style.\n\n"
          "3.  **Color Palette:** Vibrant fuchsias, blues, yellows, and greens typical of East Javanese batik.\n\n"
          "**Typical Region:** East Java (Malang, Sidoarjo, Surabaya)\n\n"
          "**Meaning:** Celebration of modern womanhood — confidence, joy, and cultural evolution.",
      "error": null
    });

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['imagePath'] != null) {
      imagePath.value = args['imagePath'] as String;
      predictBatik(File(imagePath.value));
      // loadDummyResult();
    } else {
      aiResult.value = PredictionResponse(
        error: "No image path provided.",
      );
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

  Future<void> predictBatik(File imageFile) async {
    if (aiResult.value != null) return;

    try {
      isLoading.value = true;
      final result = await _aiService.predictBatik(imageFile);
      aiResult.value = result;
    } catch (e) {
      aiResult.value = PredictionResponse(
        error: "Failed to detect batik: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
