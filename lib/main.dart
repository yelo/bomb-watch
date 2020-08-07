import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/ui/auth/authentication_screen.dart';
import 'package:bomb_watch/ui/main/master_detail/master_detail_container.dart';
import 'package:bomb_watch/ui/main/specific_video/specific_video_args.dart';
import 'package:bomb_watch/ui/main/specific_video/specific_video_screen.dart';
import 'package:bomb_watch/ui/settings/settings_screen.dart';
import 'package:bomb_watch/ui/splash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<GbClient>(GbClient());
  getIt.registerSingleton<SimplePersistentStorage>(SimplePersistentStorage());
}

Future<void> main() async {
  setupDependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      title: 'Bomb Watch',
      themeMode: ThemeMode.system,
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.light),
      darkTheme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          brightness: Brightness.dark),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // TODO: Check route name, setup better argument handling.
        final SpecificVideoScreenArgs videoArgs = settings.arguments;

        var routes = <String, WidgetBuilder>{
          '/': (context) => SplashScreen(),
          '/auth': (context) => AuthenticationScreen(),
          '/main': (context) => MasterDetailContainer(),
          '/settings': (context) => SettingsScreen(),
          '/video': (context) =>
              SpecificVideoScreen(videoArgs.guid, videoArgs.imageProvider),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }
}
