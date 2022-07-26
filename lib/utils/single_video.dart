import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:staus_saver/pages/video_play_page.dart';
import 'package:staus_saver/utils/ads.dart';
import 'package:staus_saver/utils/photo_view.dart';
import 'package:share_extend/share_extend.dart';
import 'package:video_player/video_player.dart';
//import 'package:thumbnails/thumbnails.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../constant.dart';

class SingleVideo extends StatefulWidget {
  String videoPath;
  int current_index;
  bool downloadable;
  SingleVideo(
      {Key? key,
      required this.videoPath,
      required this.current_index,
      required this.downloadable})
      : super(key: key);

  @override
  State<SingleVideo> createState() => _SingleVideoState();
}

class _SingleVideoState extends State<SingleVideo> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
    getThumbnail();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  String? thumbnail;
  getThumbnail() async {
    thumbnail = await VideoThumbnail.thumbnailFile(video: widget.videoPath);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        adCounter();
        var route = MaterialPageRoute(
            builder: (BuildContext) => VideoPlayPage(
                videopath: widget.videoPath,
                downloadable: widget.downloadable));
        Navigator.push(context, route);
      },
      child: Container(
          width: size.width / 2,
          height: size.height / 4,
          child: thumbnail != null
              ? Stack(
                  children: [
                    Image.file(
                      File(thumbnail!),
                      fit: BoxFit.fill,
                      width: size.width / 2,
                      height: size.height / 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/video_player.png",
                        height: 50,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          adCounter();
                          ShareExtend.share(widget.videoPath, "image");
                        },
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.share),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  width: size.width / 2,
                  height: size.height / 4,
                  color: Colors.grey[350],
                  child: Center(child: CircularProgressIndicator()))),
    );
  }
}
