import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({@required this.show, this.futureVideos});
  final Show show;
  final Future<GbVideos> futureVideos;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    /*final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          show?.title ?? 'Nutto selected',
          style: textTheme.subtitle1,
        ),
        Text(
          show?.deck ?? 'You mus selec',
          style: textTheme.subtitle2,
        ),
      ],
    );*/

    return Center(
      child:
      FutureBuilder<GbVideos>(
          future: futureVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(show.title),
                ),
                body: GridView.count(
                  crossAxisCount: 2,
                  children: snapshot.data.results.map((video) {
                    return Center(
                      child: Text(
                        '${video.name}',
                        style: textTheme.headline5,
                      ),
                    );
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          }
      )
    );
  }
}