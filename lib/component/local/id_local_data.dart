import 'package:shared_preferences/shared_preferences.dart';

class SetDataLocal {
  setDataIDProv(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
    await prefs.setString('action', id);
  }
}
