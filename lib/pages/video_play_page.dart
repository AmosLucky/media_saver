import 'dart:io';

import 'package:flutter/material.dart';
import 'package:staus_saver/utils/ads.dart';
import 'package:staus_saver/utils/fabs.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {
  String videopath;
  bool downloadable;
  VideoPlayPage({Key? key, required this.videopath, required this.downloadable})
      : super(key: key);

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videopath));

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.center,
          width: size.width,
          //height: 300,
          padding: const EdgeInsets.all(0),
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      showBannerAdd(
                          height: 100,
                          width: MediaQuery.of(context).size.width),
                      SizedBox(height: 100),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                          child: Container(
                              //alignment: Alignment.center,
                              //height: 500,
                              child: VideoPlayer(_controller))),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                }
                              });
                            },
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        padding: EdgeInsets.all(3),
                        colors: VideoProgressColors(
                            playedColor: Theme.of(context).primaryColor),
                      ),

                      //_ControlsOverlay(controller: _controller),
                      ///VideoProgressIndicator(_controller, allowScrubbing: true),
                    ],
                  ),
                )
              : Container(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
        bottomNavigationBar: Fabs(
            file_type: "image",
            file_path: widget.videopath,
            downloadable: widget.downloadable));
  }
}
