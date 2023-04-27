import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_flutter/pages/home/view/home_page.dart';

class SimpleFunc {
  GoToHome(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');

    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  HomePage(id: action == null ? "501195" : action.toString())));
    });
  }
}
