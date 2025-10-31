import 'dart:convert';
import 'package:batikpedia/app/data/photo_model.dart';

class BatikModel {
  int id;
  String name;
  String artist;
  int year;
  List<String> themes;
  List<PhotoModel> images;

  BatikModel({
    this.id = 0,
    required this.name,
    required this.artist,
    required this.year,
    required this.themes,
    required this.images,
  });

  factory BatikModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedThemes = [];

    if (json['_BatikTema'] is List) {
      for (var bt in json['_BatikTema']) {
        final tema = bt['Tema'];
        if (tema != null && tema['TemaTranslation'] is List) {
          for (var trans in tema['TemaTranslation']) {
            final nama = trans['nama']?.toString() ?? '';
            if (nama.isNotEmpty) {
              parsedThemes.add(nama);
            }
          }
        }
      }
    }

    List<PhotoModel> parsedImages = [];
    if (json['Foto'] is List) {
      parsedImages = (json['Foto'] as List)
          .map((f) => PhotoModel.fromJson(f))
          .toList();
    }

    return BatikModel(
      id: json['id'] is int ? json['id'] : 0,
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
