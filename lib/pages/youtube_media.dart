import 'dart:io';

import 'package:flutter/material.dart';
import 'package:staus_saver/providers/youtube_provider.dart';
import 'package:staus_saver/utils/ads.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DownloadFromYoutube extends StatefulWidget {
  String youtube_link;
  String video_id;
  DownloadFromYoutube(
      {Key? key, required this.youtube_link, required this.video_id})
      : super(key: key);

  @override
  State<DownloadFromYoutube> createState() => _DownloadFromYoutubeState();
}

class _DownloadFromYoutubeState extends State<DownloadFromYoutube> {
  YoutubeProvider youtubeProvider = YoutubeProvider();

  YoutubePlayerController? _controller;
  initialize() {
    widget.video_id;
    _controller = YoutubePlayerController(
      initialVideoId: widget.video_id,
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: true,
        autoPlay: true,
      ),
    );
  }

  stratDownloading() {
    youtubeProvider.downloadVideo(widget.youtube_link.trim());
  }

  @override
  void initState() {
    initialize();
    stratDownloading();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // showBannerAdd(
              //     height: 100, width: MediaQuery.of(context).size.width),
              Container(
                height: 400,
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                  //videoProgressIndicatorColor: Colors.amber,
                  // progressColors: ProgressColors(
                  //     playedColor: Colors.amber,
                  //     handleColor: Colors.amberAccent,
                  // ),
                  onReady: () {
                    _controller!.addListener(() {
                      _controller!.value.playerState;
                      _controller!.metadata;
                    });
                  },
                ),
              ),
              Container(
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Dowloading into your downloads folder....",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Slide down to see download progress"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
