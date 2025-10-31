import 'package:batikpedia/app/data/photo_model.dart';

class DetailBatikModel {
  final int id;
  final String name;
  final String artist;
  final String address;
  final int year;
  final String dimension;
  final List<String> themes;
  final Map<String, List<String>> groupedSubThemes;
  final List<PhotoModel> images;
  final String warna;
  final String teknik;
  final String jenisKain;
  final String pewarna;
  final String bentuk;
  final String histori;

  const DetailBatikModel({
    this.id = 0,
    required this.name,
    required this.artist,
    required this.address,
    required this.year,
    this.dimension = '-',
    required this.themes,
    required this.groupedSubThemes,
    required this.images,
    this.warna = '-',
    this.teknik = '-',
    this.jenisKain = '-',
    this.pewarna = '-',
    this.bentuk = '-',
    this.histori = '-',
  });

  factory DetailBatikModel.fromJson(Map<String, dynamic> json) {

    final List<String> parsedThemes = [];
    if (json['_BatikTema'] is List) {
      for (final bt in json['_BatikTema']) {
        final tema = bt['Tema'];
        if (tema != null && tema['TemaTranslation'] is List) {
          for (final t in tema['TemaTranslation']) {
            final nama = t['nama']?.toString();
            if (nama != null && nama.isNotEmpty) {
              parsedThemes.add(nama);
            }
          }
        }
      }
    }


    final Map<String, List<String>> groupedSubThemes = {};
    if (json['_BatikSubTema'] is List) {
      for (final entry in json['_BatikSubTema']) {
        final subTema = entry['SubTema'];
        if (subTema == null) continue;


        String themeName = 'Unknown';
        if (subTema['Tema'] != null && subTema['Tema']['TemaTranslation'] is List) {
          final trans = (subTema['Tema']['TemaTranslation'] as List).first;
          themeName = trans['nama'] ?? 'Unknown';
        }


        String subName = '';
        if (subTema['SubTemaTranslation'] is List) {
          final trans = (subTema['SubTemaTranslation'] as List).first;
          subName = trans['nama'] ?? '';
        }

        groupedSubThemes.putIfAbsent(themeName, () => []);
        if (subName.isNotEmpty) groupedSubThemes[themeName]!.add(subName);
      }
    }


    if (groupedSubThemes.isEmpty && parsedThemes.isNotEmpty) {
      for (final theme in parsedThemes) {
        groupedSubThemes.putIfAbsent(theme, () => []);
      }
    }


    final List<PhotoModel> parsedImages = (json['Foto'] as List?)
        ?.map((f) => PhotoModel.fromJson(f))
        .toList() ??
        [];


    String warna = '-', teknik = '-', jenisKain = '-', pewarna = '-', bentuk = '-', histori = '-';
    final translationData = json['BatikTranslation'];

    if (translationData != null) {

      final trans = translationData is List
          ? (translationData.isNotEmpty ? translationData.first : null)
          : translationData;

      if (trans != null) {
        warna = trans['warna'] ?? '-';
        teknik = trans['teknik'] ?? '-';
        jenisKain = trans['jenisKain'] ?? '-';
        pewarna = trans['pewarna'] ?? '-';
        bentuk = trans['bentuk'] ?? '-';
        histori = trans['histori'] ?? '-';
      }
    }

    return DetailBatikModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['nama'] ?? '',
      artist: json['seniman'] ?? '',
      address: json['alamat'] ?? '',
      year: (json['tahun'] is int)
          ? json['tahun']
          : int.tryParse(json['tahun']?.toString() ?? '0') ?? 0,
      dimension: json['dimensi'] ?? '-',
      themes: parsedThemes,
      groupedSubThemes: groupedSubThemes,
      images: parsedImages,
      warna: warna,
      teknik: teknik,
      jenisKain: jenisKain,
      pewarna: pewarna,
      bentuk: bentuk,
      histori: histori,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': name,
    'seniman': artist,
    'alamat': address,
    'tahun': year,
    'dimensi': dimension,
    'tema': themes,
    'sub_tema': groupedSubThemes,
    'foto': images.map((e) => e.toJson()).toList(),
    'warna': warna,
    'teknik': teknik,
    'jenisKain': jenisKain,
    'pewarna': pewarna,
    'bentuk': bentuk,
    'histori': histori,
  };
}
