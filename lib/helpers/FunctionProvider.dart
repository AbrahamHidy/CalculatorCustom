import 'package:shared_preferences/shared_preferences.dart';

class FunctionProvider {
  static String _savedLoggedInKey = 'ISLOGGEDIN';
  static String _savedUsernameKey = 'USERNAMEKEY';
  static String _savedEmailKey = 'EMAILKEY';

  //Savers

  static Future<bool> saveLoggedIn(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(_savedLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUsersName(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(_savedUsernameKey, username);
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

  static Future<String> getUsersName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_savedUsernameKey);
  }

  static Future<String> getUsersEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_savedEmailKey);
  }
}
