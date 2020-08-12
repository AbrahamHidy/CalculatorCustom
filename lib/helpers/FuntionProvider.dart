import 'package:shared_preferences/shared_preferences.dart';

class FuntionProvider {
  static String savedLoggedInKey = 'ISLOGGEDIN';
  static String savedUsernameKey = 'USERNAMEKEY';
  static String savedEmailKey = 'EMAILKEY';

  //Savers

  static Future<bool> saveLoggedIn(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(savedLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUsersName(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(savedUsernameKey, username);
  }

  static Future<bool> saveUsersEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(savedEmailKey, email);
  }

  //Retrievers

  static Future<bool> getLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(savedLoggedInKey);
  }

  static Future<String> getUsersName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(savedLoggedInKey);
  }

  static Future<String> getUsersEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(savedLoggedInKey);
  }
}
