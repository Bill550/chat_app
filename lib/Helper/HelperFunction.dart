import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String spUserLoggedInKey = 'ISLOGGEDIN';
  static String spUserNameKey = 'USERNAMEKEY';
  static String spUserEmailKey = 'USEREMAILKEY';

  // Saveing Data to SP

  static Future<bool> saveUserLoggedInSP(bool isUserLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(spUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSP(String isUserName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(spUserNameKey, isUserName);
  }

  static Future<bool> saveUserEmailSP(String isUserEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(spUserEmailKey, isUserEmail);
  }

  //Getting Data To SP

  static Future<bool> getUserLoggedInSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.getBool(spUserLoggedInKey);
  }

  static Future<String> getUserNameSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.getString(spUserNameKey);
  }

  static Future<String> getUserEmailSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.getString(spUserEmailKey);
  }
}
