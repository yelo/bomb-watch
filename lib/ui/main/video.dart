import 'package:bomb_watch/data/api_responses/gb_video.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:neeko/neeko.dart';

class VideoScreen extends StatefulWidget {
  String guid;

  VideoScreen(this.guid);

  @override
  State<StatefulWidget> createState() => _VideoScreenState(this.guid);
}

class _VideoScreenState extends State<VideoScreen> {
  final String guid;

  bool hasLoaded = false;

  GbClient _gbClient = GetIt.instance<GbClient>();
  Future<GbVideo> futureVideo;
  VideoControllerWrapper _videoControllerWrapper;

  _VideoScreenState(this.guid);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    futureVideo = _gbClient.fetchVideo(this.guid);
    futureVideo.then((video) {
      _videoControllerWrapper = VideoControllerWrapper(DataSource.network(
          "${video.results.hdUrl}?api_key=${_gbClient.apiKey}",
          displayName: video.results.name));

      _videoControllerWrapper.addListener(() {
        setState(() {
          hasLoaded = true;
        });
      });
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
            backgroundColor: Colors.black12,
            appBar: AppBar(
              title: Text(snapshot.hasData
                  ? snapshot.data.results?.name
                  : 'Loading...'),
            ),
            body: _getBody(snapshot),
          );
        });
  }

  _getBody(AsyncSnapshot<GbVideo> snapshot) {
    if (snapshot.hasData) {
      Video video = snapshot.data.results;
      return Column(children: <Widget>[
        AspectRatio(
            aspectRatio: 2,
            child: Stack(children: [
              Center(child: CircularProgressIndicator()),
              NeekoPlayerWidget(
                videoControllerWrapper: _videoControllerWrapper,
                playerOptions: NeekoPlayerOptions(autoPlay: false),
              ),
            ])),
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Uploaded by: ${video.user} @ ${video.publishDate}',
              style: TextStyle(color: Colors.pinkAccent),
            ))
      ]);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
  }
}
