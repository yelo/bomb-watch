import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TapGestureRecognizer _tapGestureRecognizer;
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

  void _launchGb() {
    launch('https://www.giantbomb.com/app/bombwatch/');
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _launchGb;
  }

  @override
  void dispose() {
    _controller.dispose();
    _tapGestureRecognizer.dispose();
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
                    Center(child: Text("💣 BombWatch 📺", style: TextStyle(fontSize: 32, letterSpacing: 3, color: Colors.red, fontWeight: FontWeight.bold))),
                    authInfoSection(),
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

  Widget authInfoSection() {
    return Container(
      padding: const EdgeInsets.only(top: 32, bottom: 45),
      child: new RichText(
        text: new TextSpan(
          children: [
            new TextSpan(
              text: '''Before you can start to use this app, you have to sync your account. Start by tapping on this ''',
              style: new TextStyle(color: Colors.black, fontSize: 16),
            ),
            new TextSpan(
                text: 'HYPERLINK',
                style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2),
                recognizer: _tapGestureRecognizer
            ), new TextSpan(
              text: ", it will take you to the",
              style: new TextStyle(color: Colors.black, fontSize: 16),
            ),
            new TextSpan(
              text: " \"Sync with Bombwatch\" ",
              style: new TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            new TextSpan(
              text: "page where you will see a code. You have to put down that code in the textfield just here below. After you've done that and cliked next, you should be ready to rock!",
              style: new TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
