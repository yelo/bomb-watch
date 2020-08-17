import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/data/api_responses/gb_videos.dart';
import 'package:bomb_watch/ui/main/specific_video/specific_video_screen.dart';
import 'package:bomb_watch/utils/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen(
      {@required this.show,
      @required this.futureVideos,
      @required this.scrollController});

  final Show show;
  final Future<GbVideos> futureVideos;
  final ScrollController scrollController;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _currentPosition = 0;

  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(title: Text(widget.show.title)),
          onTap: () {
            _scrollToggler();
          },
        ),
        body: FutureBuilder<GbVideos>(
            future: widget.futureVideos,
            builder: (context, snapshot) {
              return _getBody(context, snapshot);
            }));
  }

  int _getCrossAxisCount(BuildContext context) {
    var portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return portrait ? 1 : 2;
  }

  void _scrollToggler() {
    if (widget.scrollController.hasClients) {
      _currentPosition = widget.scrollController.position.pixels;
      if (_currentPosition != 0 && _position != 0) _position = 0;
      widget.scrollController
          ?.animateTo(_position,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn)
          ?.then((_) {
        _position = _currentPosition != 0 ? _currentPosition : 0;
      });
    }
  }

  _getBody(BuildContext context, AsyncSnapshot<GbVideos> snapshot) {
    //
    if (snapshot.hasData) {
      return GridView.count(
        controller: widget.scrollController,
        primary: false,
        childAspectRatio: 16 / 9,
        crossAxisCount: _getCrossAxisCount(context),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: snapshot.data.results.map((video) {
          return InkWell(
            child: Stack(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: video.image.screenLargeUrl,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                                child: CircularProgressIndicator(
                                    value: progress.progress)),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error_outline)),
                      ),
                    ),
                  ],
                  // fit: BoxFit.fill,
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
                context, video.guid, video.image.screenLargeUrl),
          );
        }).toList(),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return Center(child: CircularProgressIndicator());
  }

  _navigateToVideo(BuildContext context, String guid, String imageUrl) {
    final ImageProvider imageProvider = CachedNetworkImageProvider(imageUrl);
    var height = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: height,
            child: SpecificVideoScreen(guid, imageProvider),
          );
        });

    //Navigator.pushNamed(context, '/video',
    //    arguments: SpecificVideoScreenArgs(guid, imageProvider));
  }
}
