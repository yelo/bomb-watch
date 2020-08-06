import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SimplePersistentStorage storage = GetIt.instance<SimplePersistentStorage>();
  GbClient _gbClient = GetIt.instance<GbClient>();

  @override
  void initState() {
    super.initState();
    // Try to fetch the API key from the persistent storage
    storage.getApiKey().then((token) {
      if (token == null) {
        // If no key, start the auth flow.
        Navigator.pushReplacementNamed(context, '/auth');
      } else {
        // Else, set the key and start the 'main' part of the app.
        _gbClient.setKey(token);
        Navigator.pushReplacementNamed(context, '/main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
