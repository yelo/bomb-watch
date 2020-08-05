import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/services/gb_client.dart';
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
              itemSelectedCallback: (show) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        show: show,
                        futureVideos:
                            gbClient.fetchVideos("apiKey", 0, 10, show.id),
                      ),
                    ));
              },
              shows: snapshot.data.results);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
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

                  return CircularProgressIndicator();
                })),
        Flexible(
          flex: 3,
          child: DetailScreen(
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
