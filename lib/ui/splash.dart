import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/ui/auth/authentication.dart';
import 'package:bomb_watch/ui/main/container.dart';
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
    storage.fetchApiToken().then((token) {
      if (token == null) {
        // If no key, start the auth flow.
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => AuthenticationScreen()));
      } else {
        // Else, set the key and start the 'main' part of the app.
        _gbClient.setKey(token);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => MasterDetailContainer()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
