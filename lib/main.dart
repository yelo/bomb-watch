import 'package:bomb_watch/http/gb_client.dart';
import 'package:bomb_watch/ui/auth/authentication.dart';
import 'package:bomb_watch/ui/main/container.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<GbClient>(GbClient());
}

void main() {
  setupDependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MasterDetailContainer(),
      );
  }
}