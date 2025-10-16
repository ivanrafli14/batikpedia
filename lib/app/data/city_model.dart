import 'dart:convert';

class CityModel {
  String imagePath;
  String name;


  CityModel({
    required this.imagePath,
    required this.name,

  });

  factory CityModel.fromJson(Map<String, dynamic> json) {

    return CityModel(
      imagePath: json['image_url'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'image_path': imagePath,
    'name': name,
  };
}
