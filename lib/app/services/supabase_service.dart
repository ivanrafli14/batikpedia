import 'package:batikpedia/app/data/batik_model.dart';
import 'package:batikpedia/app/data/city_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService{
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<BatikModel>> loadBatik() async {
    final response = await supabase
        .from('Batik')
        .select('nama, seniman, tahun, Foto(link), _BatikTema(Tema(nama))')
        .limit(5);

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

}