import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/http/gb_client.dart';
import 'package:bomb_watch/main.dart';
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
  // Track the currently selected item here. Only used for
  // tablet layouts.
  Show _selectedShow;

  GbClient gbClient = GetIt.instance<GbClient>();
  Future<GbShows> futureShows;

  @override
  void initState() {
    super.initState();
    futureShows = gbClient.fetchShows("apiKey");
  }

  Widget _buildMobileLayout() {
    return FutureBuilder<GbShows>(
            future: futureShows,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MasterScreen(
                    // Since we're on mobile, just push a new route for the
                    // item details.
                    itemSelectedCallback: (show) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(show: show),
                          ));
                    },
                    shows: snapshot.data.results);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          );
  }

  Widget _buildTabletLayout() {
    // For tablets, return a layout that has item listing on the left
    // and item details on the right.
    return Row(
      children: <Widget>[
        Flexible(
            flex: 1,
            child: FutureBuilder<GbShows>(
                future: futureShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MasterScreen(
                      // Instead of pushing a new route here, we update
                      // the currently selected item, which is a part of
                      // our state now.
                      itemSelectedCallback: (show) {
                        setState(() {
                          _selectedShow = show;
                        });
                      },
                      shows: snapshot.data.results,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                })),
        Flexible(
          flex: 3,
          child: DetailScreen(
            // The item details just blindly accepts whichever
            // item we throw in its way, just like before.
            show: _selectedShow,
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
}
