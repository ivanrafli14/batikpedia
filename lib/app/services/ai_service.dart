import 'dart:convert';
import 'dart:io';
import 'package:batikpedia/app/data/prediction_response.dart';
import 'package:http/http.dart' as http;


class AiService {
  final String baseUrl = "http://31.97.66.47:5000";

  Future<PredictionResponse> predictBatik(File imageFile) async {
    final uri = Uri.parse("$baseUrl/predict");

    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      final Map<String, dynamic> data = jsonDecode(resBody);

      return PredictionResponse.fromJson(data);
    } catch (e) {
      return PredictionResponse(
        error: "Network or parsing error: ${e.toString()}",
      );
    }
  }
}
