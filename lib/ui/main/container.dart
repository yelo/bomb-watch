import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/ui/main/detail.dart';
import 'package:bomb_watch/ui/main/master.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MasterDetailContainer extends StatefulWidget {
  @override
  _MasterDetailContainerState createState() => _MasterDetailContainerState();
}

class _MasterDetailContainerState extends State<MasterDetailContainer> {
  Show _selectedShow;

  GbClient gbClient = GetIt.instance<GbClient>();
  SimplePersistentStorage simpleStorage =
      GetIt.instance<SimplePersistentStorage>();
  Future<GbShows> futureShows;

  @override
  void initState() {
    super.initState();
    futureShows = gbClient.fetchShows();
    futureShows.then((shows) => {
          simpleStorage.getFavoriteShowIds().then((ids) => {
                shows.results.forEach((show) {
                  var intIds = ids.map((e) => int.parse(e)).toList();
                  if (intIds.contains(show.id)) show.favorite = true;
                })
              })
        });
  }

  Widget _buildMobileLayout() {
    return Scaffold(
        body: Center(
      child: FutureBuilder<GbShows>(
        future: futureShows,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MasterScreen(
                toggleShowFavoriteCallback: (show) =>
                    _toggleShowAsFavorite(show),
                showSelectedCallback: (show) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          show: show,
                          futureVideos:
                              gbClient.fetchVideos(0, 10, show?.id ?? 0),
                        ),
                      ));
                },
                shows: snapshot.data.results);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
            flex: 1,
            child: FutureBuilder<GbShows>(
                future: futureShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MasterScreen(
                      toggleShowFavoriteCallback: (show) =>
                          _toggleShowAsFavorite,
                      showSelectedCallback: (show) {
                        setState(() {
                          _selectedShow = show;
                        });
                      },
                      shows: snapshot.data.results,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                })),
        Flexible(
          flex: 3,
          child: DetailScreen(
            show: _selectedShow ??
                new Show(
                    deck: null, id: 0, title: 'Latest videos', image: null),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;

    if (useMobileLayout) {
      return _buildMobileLayout();
    }

    return _buildTabletLayout();
  }

  _toggleShowAsFavorite(Show show) {
    simpleStorage.toggleShowAsFavorite(show.id);
    show.favorite = !show.favorite;
    setState(() {
      // just update state.
    });
  }
}
