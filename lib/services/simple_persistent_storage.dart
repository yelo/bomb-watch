import 'package:shared_preferences/shared_preferences.dart';

class SimplePersistentStorage {
  static const String API_TOKEN_VALUE_KEY = "API_TOKEN_VALUE_KEY";

  void saveApiKey(String apiKey, String expiration) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(API_TOKEN_VALUE_KEY, apiKey);
  }

  Future<String> fetchApiToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(API_TOKEN_VALUE_KEY);
  }
}