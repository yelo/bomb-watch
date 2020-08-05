import 'package:shared_preferences/shared_preferences.dart';

class SimplePersistentStorage {
  static const String API_KEY_PREFERENCE = "API_KEY_PREFERENCE";

  void saveApiKey(String apiKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(API_KEY_PREFERENCE, apiKey);
  }

  Future<String> getApiKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(API_KEY_PREFERENCE);
  }

  void clearApiToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(API_KEY_PREFERENCE);
  }
}