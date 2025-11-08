class PredictionResponse {
  final String? predictedBatik;
  final double? similarityScore;
  final String? description;
  final String? error;

  PredictionResponse({
    this.predictedBatik,
    this.similarityScore,
    this.description,
    this.error,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      predictedBatik: json['predicted_batik'],
      similarityScore: json['similarity_score'] != null
          ? (json['similarity_score'] as num).toDouble()
          : null,
      description: json['description'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predicted_batik': predictedBatik,
      'similarity_score': similarityScore,
      'description': description,
      'error': error,
    };
  }

  bool get isSuccess => error == null;
}
