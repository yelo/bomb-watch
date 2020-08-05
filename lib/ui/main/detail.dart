import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:cache_image/cache_image.dart';
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
        child: FutureBuilder<GbVideos>(
            future: futureVideos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(show.title),
                  ),
                  body: GridView.count(
                    crossAxisCount: 1,
                    children: snapshot.data.results.map((video) {
                      return Center(
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: CacheImage(video.image.mediumUrl),
                            placeholder: AssetImage("assets/placeholder"),
                        )
                      );
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            }));
  }
}
