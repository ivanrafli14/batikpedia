import 'dart:convert';

class PhotoModel {
  String imagePath;


  PhotoModel({
    required this.imagePath,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {

    return PhotoModel(
      imagePath: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'image_path': imagePath,
  };
}
