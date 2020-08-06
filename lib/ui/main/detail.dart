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
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;
    if (snapshot.hasData) {
      return GridView.count(
        primary: false,
        childAspectRatio: 16 / 9,
        crossAxisCount: useMobileLayout ? 1 : 3,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: snapshot.data.results.map((video) {
          return Container(
              color: Colors.transparent,
              child: InkWell(
                child: Stack(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: video.image.screenUrl,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                                child: CircularProgressIndicator(
                                    value: progress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        color: Colors.black87,
                        padding: EdgeInsets.all(5),
                        child: Text(
                            "${video.name}${video.premium ? ' - Premium!' : ''}",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.black87,
                              child: Text(video.deck,
                                  style: TextStyle(color: Colors.white)),
                            )))
                  ],
                ),
                onTap: () => _navigateToVideo(context, video.guid),
              ));
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
