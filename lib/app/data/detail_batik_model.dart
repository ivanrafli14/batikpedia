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

    final List<String> parsedThemes = (json['_BatikTema'] as List?)
        ?.map((bt) => bt['Tema']?['nama']?.toString() ?? '')
        .where((t) => t.isNotEmpty)
        .cast<String>()
        .toList() ??
        [];


    final Map<String, List<String>> groupedSubThemes = {};

    if (json['_BatikSubTema'] is List && (json['_BatikSubTema'] as List).isNotEmpty) {
      for (final entry in (json['_BatikSubTema'] as List)) {
        final subTema = entry['SubTema'];
        if (subTema == null) continue;

        final themeName = subTema['Tema']?['nama'] ?? 'Unknown';
        String subName = subTema['nama'] ?? '';


        if (subTema['SubTemaTranslation'] is List) {
          final indo = (subTema['SubTemaTranslation'] as List).firstWhere(
                (t) => t['languageId'] == 2,
            orElse: () => null,
          );
          subName = indo?['nama'] ?? subName;
        }

        groupedSubThemes.putIfAbsent(themeName, () => []);
        if (subName.isNotEmpty) groupedSubThemes[themeName]!.add(subName);
      }
    }

    if (groupedSubThemes.isEmpty && json['_BatikTema'] is List) {
      for (final tema in (json['_BatikTema'] as List)) {
        final nama = tema['Tema']?['nama'] ?? 'Unknown';
        groupedSubThemes[nama] = [];
      }
    }


    for (final theme in parsedThemes) {
      groupedSubThemes.putIfAbsent(theme, () => []);
    }


    final List<PhotoModel> parsedImages = (json['Foto'] as List?)
        ?.map((f) => PhotoModel.fromJson(f))
        .toList() ??
        [];


    String warna = '-', teknik = '-', jenisKain = '-', pewarna = '-', bentuk = '-', histori = '-';
    if (json['BatikTranslation'] is List) {
      final indo = (json['BatikTranslation'] as List).firstWhere(
            (bt) => bt['languageId'] == 2,
        orElse: () => null,
      );
      if (indo != null) {
        warna = indo['warna'] ?? '-';
        teknik = indo['teknik'] ?? '-';
        jenisKain = indo['jenisKain'] ?? '-';
        pewarna = indo['pewarna'] ?? '-';
        bentuk = indo['bentuk'] ?? '-';
        histori = indo['histori'] ?? '-';
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
