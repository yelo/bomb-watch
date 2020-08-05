import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({@required this.show, this.futureVideos});

  final Show show;
  final Future<GbVideos> futureVideos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(show.title)),
        body: FutureBuilder<GbVideos>(
            future: futureVideos,
            builder: (context, snapshot) {
              return _getBody(context, snapshot);
            }));
  }

  _getBody(BuildContext context, AsyncSnapshot<GbVideos> snapshot) {
    if (snapshot.hasData) {
      return GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: snapshot.data.results.map((video) {
          return InkWell(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: video.image.screenUrl,
              progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(value: progress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            onTap: () => _navigateToVideo(context, video.guid),
          );
        }).toList(),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return Center(child: CircularProgressIndicator());
  }

  _navigateToVideo(BuildContext context, String guid) {
    Navigator.pushNamed(context, '/video', arguments: guid);
  }
}
