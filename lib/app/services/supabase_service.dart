import 'package:batikpedia/app/data/batik_model.dart';
import 'package:batikpedia/app/data/city_model.dart';
import 'package:batikpedia/app/data/detail_batik_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService{
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<BatikModel>> loadBatikForHomeView({
    List<int>? ids,
    int? languageId,
  }) async {

    final targetIds = ids ?? [432, 437, 362, 435, 429, 436];

    var query = supabase
        .from('Batik')
        .select('''
          id,
          nama,
          seniman,
          tahun,
          Foto(link),
          _BatikTema!inner(
            Tema!inner(
              id,
              TemaTranslation(
                nama,
                languageId
              )
            )
          )
        ''')
        .eq('_BatikTema.Tema.TemaTranslation.languageId', languageId ?? 2)
        .inFilter('id', targetIds);



    final response = await query;

    if (response == null) {
      throw Exception('No data returned from Supabase');
    }

    print("DEBUG Home Batik Response:");
    print(response);

    return (response as List)
        .map((json) => BatikModel.fromJson(json))
        .toList();
  }


  Future<List<BatikModel>> loadBatik({
    int page = 1,
    int limit = 6,
    String? searchQuery,
    List<String>? filteredCities,
    int? languageId,
  }) async {
    final int start = (page - 1) * limit;
    final int end = start + limit - 1;

    var query = supabase
        .from('Batik')
        .select('''
          id,
          nama,
          seniman,
          tahun,
          Foto(link),
          _BatikTema(
            Tema(
              id,
              TemaTranslation!inner(nama, languageId)
            )
          )
        ''')
        .eq('_BatikTema.Tema.TemaTranslation.languageId', languageId ?? 2);


    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.ilike('nama', '%$searchQuery%');
    }

    if (filteredCities != null && filteredCities.isNotEmpty) {
      if (!filteredCities.contains('All')) {
        query = query.inFilter('pointmap', filteredCities);
      }
    }

    final response = await query
        .order('tahun', ascending: false)
        .range(start, end);

    if (response == null) {
      throw Exception('No data returned from Supabase');
    }

    print("DEBUG Batik Response:");
    print(response);

    // Convert ke model
    return (response as List)
        .map((json) => BatikModel.fromJson(json))
        .toList();
  }

  
  Future<List<CityModel>> loadCity() async {
    final response = await supabase
        .from('City')
        .select();

    print("City:");
    print(response);

    return (response as List)
        .map((json) => CityModel.fromJson(json))
        .toList();
  }

  Future<DetailBatikModel> loadDetailBatik(int batikId, {int? languageId}) async {
    print("Loading detail for Batik ID: $batikId");

    var query = supabase
        .from('Batik')
        .select('''
        id,
        nama,
        seniman,
        alamat,
        tahun,
        dimensi,
        Foto(link),
        _BatikTema(
          Tema(
            id,
            TemaTranslation!inner(nama, languageId)
          )
        ),
        _BatikSubTema(
          SubTema(
            id,
            SubTemaTranslation!inner(nama, languageId),
            Tema(
              id,
              TemaTranslation!inner(nama, languageId)
            )
          )
        ),
        BatikTranslation!inner(languageId, warna, teknik, jenisKain, pewarna, bentuk, histori)
      ''')
        .eq('id', batikId)
        .eq('_BatikTema.Tema.TemaTranslation.languageId', languageId ?? 2)
        .eq('_BatikSubTema.SubTema.SubTemaTranslation.languageId', languageId ?? 2)
        .eq('BatikTranslation.languageId', languageId ?? 2);

    final response = await query.single();

    print("Detail Batik:");
    print(response);

    return DetailBatikModel.fromJson(response);
  }


}