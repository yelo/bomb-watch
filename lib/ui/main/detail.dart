import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:bomb_watch/main.dart';
import 'package:bomb_watch/utils/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen(
      {@required this.show,
      @required this.futureVideos,
      @required this.scrollController});

  final Show show;
  final Future<GbVideos> futureVideos;
  final ScrollController scrollController;

  double _currentPosition = 0;
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(title: Text(show.title)),
          onTap: () {
            _scrollToggler();
          },
        ),
        body: FutureBuilder<GbVideos>(
            future: futureVideos,
            builder: (context, snapshot) {
              return _getBody(context, snapshot);
            }));
  }

  int _getCrossAxisCount(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;

    if (useMobileLayout) return orientation == Orientation.portrait ? 1 : 2;
    return 2;
  }

  void _scrollToggler() {
    if (scrollController.hasClients)
      _currentPosition = scrollController.position.pixels;
    scrollController
        ?.animateTo(_position,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn)
        .then((_) {
      _position = _currentPosition != 0 ? _currentPosition : 0;
    });
  }

  _getBody(BuildContext context, AsyncSnapshot<GbVideos> snapshot) {
    //
    if (snapshot.hasData) {
      return GridView.count(
        controller: scrollController,
        primary: false,
        childAspectRatio: 16 / 9,
        crossAxisCount: _getCrossAxisCount(context),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                onTap: () => _navigateToVideo(
                    context, video.guid, video.image.screenUrl),
              ));
        }).toList(),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return Center(child: CircularProgressIndicator());
  }

  _navigateToVideo(BuildContext context, String guid, String imageUrl) {
    final ImageProvider imageProvider = CachedNetworkImageProvider(imageUrl);
    /*showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            child: VideoScreen(guid, imageProvider),
          );
        });*/

    Navigator.pushNamed(context, '/video',
        arguments: VideoArgs(guid, imageProvider));
  }
}
