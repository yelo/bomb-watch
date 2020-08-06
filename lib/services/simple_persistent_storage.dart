import 'package:shared_preferences/shared_preferences.dart';

class SimplePersistentStorage {
  static const String API_KEY_PREFERENCE = "API_KEY_PREFERENCE";
  static const String FAVORITE_SHOWS = "FAVORITE_SHOWS";

  void saveApiKey(String apiKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(API_KEY_PREFERENCE, apiKey);
  }

  Future<String> getApiKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(API_KEY_PREFERENCE);
  }

  void clearApiToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(API_KEY_PREFERENCE);
  }

  void toggleShowAsFavorite(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var favorites = await getFavoriteShowIds();
    if (!favorites.contains('$id'))
      favorites.add('$id');
    else
      favorites.remove('$id');
    await preferences.setStringList(FAVORITE_SHOWS, favorites);
  }

  Future<List<String>> getFavoriteShowIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(FAVORITE_SHOWS) ?? [];
  }
}
