import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:bomb_watch/ui/main/video.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({@required this.show, this.futureVideos});

  final Show show;
  final Future<GbVideos> futureVideos;

  @override
  Widget build(BuildContext context) {
    /*final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
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
              return Scaffold(
                appBar: AppBar(
                  title: Text(show?.title ?? 'Latest'),
                ),
                body: Center(child: _getBody(context, snapshot)),
              );
            }));
  }

  _getBody(BuildContext context, AsyncSnapshot<GbVideos> snapshot) {
    if (snapshot.hasData) {
      return GridView.count(
        crossAxisCount: 1,
        children: snapshot.data.results.map((video) {
          return InkWell(
            child: Container(
              child: Center(
                  child: FadeInImage(
                fit: BoxFit.cover,
                image: CacheImage(video.image.mediumUrl),
                placeholder: AssetImage("assets/placeholder"),
              )),
            ),
            onTap: () => _navigateToVideo(context, video.guid),
          );
        }).toList(),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return CircularProgressIndicator();
  }

  _navigateToVideo(BuildContext context, String guid) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => VideoScreen(guid)));
  }
}
