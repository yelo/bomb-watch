import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/ui/auth/authentication.dart';
import 'package:bomb_watch/ui/main/container.dart';
import 'package:bomb_watch/ui/main/video.dart';
import 'package:bomb_watch/ui/settings/settings.dart';
import 'package:bomb_watch/ui/splash.dart';
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
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          '/': (context) => SplashScreen(),
          '/auth': (context) => AuthenticationScreen(),
          '/main': (context) => MasterDetailContainer(),
          '/settings': (context) => SettingsScreen(),
          '/video': (context) => VideoScreen(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }
}
