import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/ui/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({
    @required this.itemSelectedCallback,
    this.shows,
    this.selectedShow,
  });

  final ValueChanged<Show> itemSelectedCallback;
  final Show selectedShow;
  final List<Show> shows;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to the Bomb Watch'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          )
        ],
      ),
      body: ListView(
        children: _getTiles(shows)),
      );
  }

  // IMPLEMENT: Main, Favorites, Rest https://flutter.dev/docs/cookbook/lists/mixed-list
  _getTiles(List<Show> shows) {
    List<Widget> tiles = new List<Widget>();
    tiles.add(ListTile(
      title: const Text('Latest videos'),
    ));
    tiles.add(Divider(height: 5.0));
    shows.forEach((show) {
      tiles.add(ListTile(
        title: Text(show.title),
        onTap: () => itemSelectedCallback(show),
        selected: selectedShow == show));
      tiles.add(Divider(height: 5.0));
    });

    return tiles;
  }
}
