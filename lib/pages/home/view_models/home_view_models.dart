import 'package:http/http.dart' as http;
import '../../../services/service.dart';

class WilayahViewModels {
  ApiService _apiService = ApiService();

  getProvince() async {
    http.Response response =
        await _apiService.getApiData('/BMKG-importer/cuaca/wilayah.json');
    return response;
  }

  getDetailWeather(String id) async {
    http.Response response =
        await _apiService.getApiData('/BMKG-importer/cuaca/$id.json');
    return response;
  }
}
