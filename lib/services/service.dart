import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "ibnux.github.io";

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future getApiData(String path) async {
    var _fullUrl = Uri.https(
      _url,
      path,
    );
    return await http.get(_fullUrl, headers: _setHeaders());
  }
}
