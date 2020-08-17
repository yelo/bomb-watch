import 'package:bomb_watch/data/api_responses/gb_video.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:neeko/neeko.dart';

class SpecificVideoScreen extends StatefulWidget {
  final String guid;
  final ImageProvider imageProvider;

  SpecificVideoScreen(this.guid, this.imageProvider);

  @override
  State<StatefulWidget> createState() =>
      _SpecificVideoScreenState(this.guid, this.imageProvider);
}

class _SpecificVideoScreenState extends State<SpecificVideoScreen> {
  final String guid;
  final ImageProvider imageProvider;

  GbClient _gbClient = GetIt.instance<GbClient>();
  Future<GbVideo> futureVideo;
  VideoControllerWrapper _videoControllerWrapper;

  _SpecificVideoScreenState(this.guid, this.imageProvider);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    futureVideo = _gbClient.fetchVideo(this.guid);
    futureVideo.then((video) {
      _videoControllerWrapper = VideoControllerWrapper(DataSource.network(
          "${video.results.hdUrl ?? video.results.highUrl}?api_key=${_gbClient.apiKey}",
          displayName: video.results.name));
    });
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GbVideo>(
        future: futureVideo,
        builder: (context, snapshot) {
          return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
                child: _getBody(snapshot)),
          );
        });
  }

  _getBody(AsyncSnapshot<GbVideo> snapshot) {
    if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Stack(children: _getVideoPlayerStack(snapshot.hasData))));
  }

  List<Widget> _getVideoPlayerStack(bool hasData) {
    var widgets = new List<Widget>();
    widgets.add(Center(child: CircularProgressIndicator()));
    if (hasData)
      widgets.add(Center(
        child: NeekoPlayerWidget(
          videoControllerWrapper: _videoControllerWrapper,
          playerOptions: NeekoPlayerOptions(autoPlay: false),
        ),
      ));
    return widgets;
  }
}
