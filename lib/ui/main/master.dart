import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({
    @required this.showSelectedCallback,
    @required this.toggleShowFavoriteCallback,
    this.shows,
    this.selectedShow,
  });

  final ValueChanged<Show> showSelectedCallback;
  final ValueChanged<Show> toggleShowFavoriteCallback;
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
              Navigator.pushNamed(context, '/settings');
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
    Show staticLatestShow = new Show(deck: '', id: 0, title: 'Latest videos', image: null);
    List<Widget> tiles = new List<Widget>();
    tiles.add(ListTile(
      title: const Text('Latest videos'),
      onTap: () => showSelectedCallback(staticLatestShow),
    ));
    tiles.add(Divider(height: 5.0));
    shows.forEach((show) {
      tiles.add(ListTile(
        title: Text(show.title),
        trailing: Icon(Icons.local_dining, color: show.favorite ? Colors.green : Colors.red),
        onLongPress: () => toggleShowFavoriteCallback(show),
        onTap: () => showSelectedCallback(show),
        selected: selectedShow?.id == show?.id));
      tiles.add(Divider(height: 5.0));
    });
    return tiles;
  }
}
