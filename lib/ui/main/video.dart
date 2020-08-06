import 'package:bomb_watch/data/api_responses/gb_video.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:neeko/neeko.dart';

class VideoScreen extends StatefulWidget {
  String guid;
  ImageProvider imageProvider;

  VideoScreen(this.guid, this.imageProvider);

  @override
  State<StatefulWidget> createState() =>
      _VideoScreenState(this.guid, this.imageProvider);
}

class _VideoScreenState extends State<VideoScreen> {
  final String guid;
  final ImageProvider imageProvider;

  GbClient _gbClient = GetIt.instance<GbClient>();
  Future<GbVideo> futureVideo;
  VideoControllerWrapper _videoControllerWrapper;

  _VideoScreenState(this.guid, this.imageProvider);

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
            appBar: AppBar(
                title: Text(snapshot.hasData
                    ? snapshot.data.results.name
                    : 'Loading...')),
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
    if (snapshot.hasData) {
      Video video = snapshot.data.results;
      return Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Stack(children: [
                    Center(child: CircularProgressIndicator()),
                    NeekoPlayerWidget(
                      videoControllerWrapper: _videoControllerWrapper,
                      playerOptions: NeekoPlayerOptions(autoPlay: false),
                    ),
                  ]))));
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return Container(
        child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Stack(children: [
                  Center(child: CircularProgressIndicator()),
                ]))));
  }
}
