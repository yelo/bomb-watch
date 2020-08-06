import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsScreen extends StatelessWidget {
  SimplePersistentStorage _storage = GetIt.instance<SimplePersistentStorage>();
  GbClient _client = GetIt.instance<GbClient>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: FlatButton(
            child: Text("Logout"), onPressed: () => _clearApiKey(context)),
      ),
    );
  }

  _clearApiKey(BuildContext context) async {
    await _storage.clearApiToken();
    _client.clearKey();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/auth', (Route<dynamic> route) => false);
  }
}
