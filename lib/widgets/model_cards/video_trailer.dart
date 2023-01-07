import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTrailerDisplay extends StatefulWidget {
  const VideoTrailerDisplay(
      {super.key, this.videoModel, required this.keys, required this.name});
  final VideoModel? videoModel;
  final String keys, name;
  @override
  State<VideoTrailerDisplay> createState() => _VideoTrailerDisplayState();
}

class _VideoTrailerDisplayState extends State<VideoTrailerDisplay> {
  late YoutubePlayerController videoController;

  @override
  void initState() {
    // var url = 'https://www.youtube.com/watch?v=${widget.keys}';
    videoController = YoutubePlayerController(
      initialVideoId: widget.keys,
    );

    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    videoController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: videoController),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.name),
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                elevation: 0,
                backgroundColor: Colors.pink,
              ),
              body: ListView(
                children: [
                  player,
                ],
              ));
        });
  }
}
