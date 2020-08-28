import 'package:shared_preferences/shared_preferences.dart';

class PreferenceSaver {
  static String _savedLoggedInKey = 'ISLOGGEDIN';
  static String _savedUserIDKey = 'USERIDKEY';
  static String _savedEmailKey = 'EMAILKEY';

  //Savers

  static Future<bool> saveLoggedIn(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(_savedLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUsersId(String userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(_savedUserIDKey, userID);
  }

  static Future<bool> saveUsersEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(_savedEmailKey, email);
  }

  //Retrievers

  static Future<bool> getLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_savedLoggedInKey);
  }

  static Future<String> getUsersId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_savedUserIDKey);
  }

  static Future<String> getUsersEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_savedEmailKey);
  }
}
