import 'package:auto_orientation/auto_orientation.dart';
import 'package:bomb_watch/data/api_responses/gb_video.dart';
import 'package:bomb_watch/services/gb_client.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  String guid;

  VideoScreen(this.guid);

  @override
  State<StatefulWidget> createState() => _VideoScreenState(this.guid);
}

class _VideoScreenState extends State<VideoScreen> {
  GbClient _gbClient = GetIt.instance<GbClient>();

  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie _playerWidget;

  String guid;
  Future<GbVideo> futureVideo;

  _VideoScreenState(this.guid);

  @override
  void initState() {
    super.initState();
    futureVideo = _gbClient.fetchVideo(this.guid);
    futureVideo.then((video) {
      _videoPlayerController = VideoPlayerController.network(
          "${video.results.hdUrl}?api_key=${_gbClient.apiKey}")
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });

      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          // aspectRatio: 3 / 2,
          //_videoPlayerController.value.aspectRatio,
          autoPlay: false,
          showControls: true,
          showControlsOnInitialize: true,
          looping: false,
          autoInitialize: false,
          routePageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondAnimation, provider) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return VideoScaffold(
                  child: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    body: Container(
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: provider,
                    ),
                  ),
                );
              },
            );
          });

      _playerWidget = Chewie(controller: _chewieController);
    });
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) _videoPlayerController.dispose();
    if (_chewieController != null) _chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<GbVideo>(
            future: futureVideo,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.hasData
                      ? snapshot.data.results?.name
                      : 'Loading...'),
                ),
                body: _getBody(snapshot),
              );
            }));
  }

  _getBody(AsyncSnapshot<GbVideo> snapshot) {
    if (snapshot.hasData) {
      return Center(

        child: Chewie(
          controller: _chewieController,
        ),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return Center(child: CircularProgressIndicator());
  }
}

class VideoScaffold extends StatefulWidget {
  const VideoScaffold({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _VideoScaffoldState();
}

class _VideoScaffoldState extends State<VideoScaffold> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    AutoOrientation.landscapeAutoMode();
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
