import 'package:bomb_watch/data/api_responses/gb_live.dart';
import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:bomb_watch/services/simple_persistent_storage.dart';
import 'package:bomb_watch/screens/main/master_detail/screens/detail_screen.dart';
import 'package:bomb_watch/screens/main/master_detail/screens/master_screen.dart';
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
  Future<GbLive> gbLive;

  ScrollController masterScrollController;
  ScrollController detailScrollController;

  @override
  void initState() {
    super.initState();
    masterScrollController = ScrollController();
    detailScrollController = ScrollController();

    gbLive = gbClient.fetchLive();

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
                scrollController: masterScrollController,
                toggleShowFavoriteCallback: (show) =>
                    _toggleShowAsFavorite(show),
                showSelectedCallback: (show) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          scrollController: detailScrollController,
                          show: show,
                          futureVideos:
                              gbClient.fetchVideos(0, 10, show?.id ?? 0),
                        ),
                      ));
                },
                live: gbLive,
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
    var portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Row(
      children: <Widget>[
        Flexible(
            flex: 1,
            child: FutureBuilder<GbShows>(
                future: futureShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MasterScreen(
                      scrollController: masterScrollController,
                      toggleShowFavoriteCallback: (show) =>
                          _toggleShowAsFavorite(show),
                      showSelectedCallback: (show) {
                        detailScrollController.animateTo(0,
                            duration: Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn);
                        setState(() {
                          _selectedShow = show;
                        });
                      },
                      live: gbLive,
                      shows: snapshot.data.results,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                })),
        Flexible(
          flex: portrait ? 1 : 2,
          child: DetailScreen(
            scrollController: detailScrollController,
            futureVideos: gbClient.fetchVideos(0, 10, _selectedShow?.id ?? 0),
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
    setState(() {});
  }
}
