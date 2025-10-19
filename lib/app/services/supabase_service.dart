import 'package:batikpedia/app/data/batik_model.dart';
import 'package:batikpedia/app/data/city_model.dart';
import 'package:batikpedia/app/data/detail_batik_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService{
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<BatikModel>> loadBatik({
    int page = 1,
    int limit = 6,
    String? searchQuery,
    List<String>? filteredCities,
  }) async {
    final int start = (page - 1) * limit;
    final int end = start + limit - 1;

    var query = supabase
        .from('Batik')
        .select('id, nama, seniman, tahun, Foto(link), _BatikTema(Tema(nama))');

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.ilike('nama', '%$searchQuery%');
    }

    if (filteredCities != null && filteredCities.isNotEmpty) {
      if (!filteredCities.contains('All')) {
        query = query.inFilter('pointmap', filteredCities);
      }
    }

    final response = await query.order('tahun', ascending: false).range(start, end);

    print("Batik:");
    print(response);


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

  Future<DetailBatikModel> loadDetailBatik(int batikId) async {
    print("Loading detail for Batik ID: $batikId");

    final response = await supabase
        .from('Batik')
        .select('''
      id,
      nama,
      seniman,
      alamat,
      tahun,
      dimensi,
      Foto(link),
      _BatikSubTema(
        SubTema(
          nama,
          Tema(nama),
          SubTemaTranslation(languageId, nama)
        )
      ),
      _BatikTema(Tema(nama)),
      BatikTranslation(languageId, warna, teknik, jenisKain, pewarna, bentuk, histori)
    ''')
        .eq('id', batikId)
        .single();




    print("Detail Batik:");
    print(response);

    return DetailBatikModel.fromJson(response);
  }

}