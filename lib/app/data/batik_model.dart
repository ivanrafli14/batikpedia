import 'dart:convert';
import 'package:batikpedia/app/data/photo_model.dart';

class BatikModel {
  String name;
  String artist;
  int year;
  List<String> themes;
  List<PhotoModel> images;

  BatikModel({
    required this.name,
    required this.artist,
    required this.year,
    required this.themes,
    required this.images,
  });

  factory BatikModel.fromJson(Map<String, dynamic> json) {

    List<String> parsedThemes = [];
    if (json['_BatikTema'] is List) {
      parsedThemes = (json['_BatikTema'] as List)
          .map((bt) => bt['Tema']?['nama']?.toString() ?? '')
          .where((t) => t.isNotEmpty)
          .toList();
    }


    List<PhotoModel> parsedImages = [];
    if (json['Foto'] is List) {
      parsedImages = (json['Foto'] as List)
          .map((f) => PhotoModel.fromJson(f))
          .toList();
    }

    return BatikModel(
      name: json['nama'] ?? '',
      artist: json['seniman'] ?? '',
      year: (json['tahun'] is int)
          ? json['tahun']
          : int.tryParse(json['tahun'].toString()) ?? 0,
      themes: parsedThemes,
      images: parsedImages,
    );
  }

  Map<String, dynamic> toJson() => {
    'nama': name,
    'seniman': artist,
    'tahun': year,
    'tema': themes,
    'foto': images.map((e) => e.toJson()).toList(),
  };
}
