import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      showToast(token.regToken != null).whenComplete(() {
        if (token.regToken != null) {
          _storage.saveApiKey(token.regToken);
          _gbClient.setKey(token.regToken);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/main', (Route<dynamic> route) => false);
        }
      });
    });
  }

  Future<bool> showToast(bool success) {
    return Fluttertoast.showToast(
      msg: success ? 'Account synced!' : 'Unable to sync acccount',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: success ? Colors.green : Colors.red,
    );
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Sync your account'),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    authInfoSection,
                    authInputSection(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Container authInputSection() {
    return Container(
        child: TextField(
      decoration: new InputDecoration(hintText: "Reg code goes here"),
      controller: _controller,
      onSubmitted: fetchAndSetApiKey,
    ));
  }

  Widget authInfoSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );
}
