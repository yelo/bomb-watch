import 'package:shared_preferences/shared_preferences.dart';

class SimplePersistentStorage {
  static const String API_PREFERENCE = "API_PREFERENCE_KEY";

  void saveApiKey(String apiKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(API_PREFERENCE, apiKey);
  }

  Future<String> readApiKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(API_PREFERENCE);
  }
}
