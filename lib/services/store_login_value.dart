import 'package:shared_preferences/shared_preferences.dart';

class StoreLoginValue {
  static const sharePreferenceEmailId = "emailId";
  static const sharePreferencePassword = "password";
  static const sharePreferenceUserId = "userId";
  static const sharePreferenceUserName = "userName";
  static const sharePreferenceToken = "token";
  static Future<void> storeLoginDetails({
    required String email,
    required String passworrd,
    required String userId,
    required String userName,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(sharePreferenceEmailId, email);
    prefs.setString(sharePreferencePassword, passworrd);
    prefs.setString(sharePreferenceUserId, userId);
    prefs.setString(sharePreferenceUserName, userName);
    prefs.setString(sharePreferenceToken, token);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferenceEmailId);
  }

  static Future<String?> getUserPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferencePassword);
  }

  static Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferenceUserId);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferenceUserName);
  }
  static Future<String?> getTokenId()async{
     final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferenceToken);
  }
}
