import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/ui/main/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _controller;
  GbClient _gbClient = GetIt.instance<GbClient>();
  SimplePersistentStorage _storage = GetIt.instance<SimplePersistentStorage>();

  void fetchAndSetApiKey(String regCode) async {
    _gbClient.fetchApiKey(regCode).then((token) async {
      if (token.regToken == null) {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("ERROR ERROR"),
                content: Text(
                    "We were unable to authenticate you, are you sure you got the code right?"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  )
                ],
              );
            });
        return;
      }
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Authenticade"),
              content: Text("You are now authenticated!"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    _storage.saveApiKey(token.regToken, token.expiration);
                    _gbClient.setKey(token.regToken);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MasterDetailContainer()));
                  },
                  child: const Text("Let's-a go!"),
                )
              ],
            );
          });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticate'),
      ),
      body: Center(
          child: TextField(
        controller: _controller,
        onSubmitted: fetchAndSetApiKey,
      )),
    );
  }
}
