import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/utils/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen({
    @required this.showSelectedCallback,
    @required this.toggleShowFavoriteCallback,
    @required this.scrollController,
    this.shows,
    this.selectedShow,
  });

  final ScrollController scrollController;
  final ValueChanged<Show> showSelectedCallback;
  final ValueChanged<Show> toggleShowFavoriteCallback;
  final Show selectedShow;
  final List<Show> shows;

  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  double _currentPosition = 0;
  double _position = 0;

  void _scrollToggler() {
    if (widget.scrollController.hasClients) {
      _currentPosition = widget.scrollController.position.pixels;
      if (_currentPosition != 0 && _position != 0) _position = 0;
      widget.scrollController
          .animateTo(_position,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn)
          .then((_) {
        _position = _currentPosition != 0 ? _currentPosition : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
        onTap: () {
          _scrollToggler();
        },
      ),
      body: ListView(
          controller: widget.scrollController,
          children: _getTiles(widget.shows)),
    );
  }

  _getTiles(List<Show> shows) {
    var favs = shows.where((show) => show.favorite);
    var rest = shows.where((show) => !show.favorite);

    Show staticLatestShow =
        new Show(deck: '', id: 0, title: 'Latest videos', image: null);
    List<Widget> tiles = new List<Widget>();

    tiles.add(ListTile(
      trailing: IconButton(
        icon: Icon(Icons.sentiment_very_satisfied, color: Colors.red),
        onPressed: () {/* Do nothing */},
      ),
      title: const Text('Latest videos'),
      onTap: () => widget.showSelectedCallback(staticLatestShow),
    ));

    if (favs.length > 0) {
      tiles.add(Divider(height: 5.0));
      tiles.add(getHeadingItem('Favorites'));
      tiles.add(Divider(height: 5.0));
      favs.forEach((show) {
        tiles.add(getListShowItem(show));
        tiles.add(Divider(height: 5.0));
      });
    }

    tiles.add(getHeadingItem('Shows'));

    rest.forEach((show) {
      tiles.add(Divider(height: 5.0));
      tiles.add(getListShowItem(show));
    });

    return tiles;
  }

  ListTile getListShowItem(Show show) {
    return ListTile(
        title: Text(show.title),
        subtitle: Container(
          padding: EdgeInsets.only(top: 3),
          child: Text(show.deck, style: TextStyle(fontSize: 12)),
        ),
        trailing: IconButton(
            icon: Icon(show.favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red),
            onPressed: () => widget.toggleShowFavoriteCallback(show)),
        onTap: () => widget.showSelectedCallback(show),
        selected: widget.selectedShow?.id == show?.id);
  }

  ListTile getHeadingItem(String title) {
    return ListTile(
        enabled: false,
        title:
            Text('$title', style: TextStyle(fontSize: 28, color: Colors.red)));
  }
}
