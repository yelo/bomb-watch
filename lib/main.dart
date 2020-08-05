import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/ui/main/container.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<GbClient>(GbClient());
  getIt.registerSingleton<SimplePersistentStorage>(SimplePersistentStorage());
}

void main() {
  setupDependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bomb Watch',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Center(child: MasterDetailContainer()),
    );
  }
}
