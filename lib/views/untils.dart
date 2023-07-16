import 'package:shared_preferences/shared_preferences.dart';

Future<String> getEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("email") ?? "--";
}
