import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staus_saver/providers/satus_save.dart';
import 'package:staus_saver/providers/whatsapp_provider.dart';
import 'package:staus_saver/utils/single_image.dart';
import 'package:staus_saver/utils/single_video.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  StatusSaver statusSaver = StatusSaver();
  var imgList = [];
  var videoList = [];
  var savedMediaList = [];
  @override
  void initState() {
    imgList = statusSaver.readImages();
    videoList = statusSaver.readVideos();
    savedMediaList = statusSaver.readMedia();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(videoList);
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: savedMedia());
  }

  Widget savedMedia() {
    return imgList.length > 0
        ? Container(
            child: AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 5,
              itemCount: savedMediaList.length,
              //reverse: true,
              itemBuilder: (context, index) {
                return savedMediaList[index].toString().endsWith(".jpg")
                    ? SingleImage(
                        imgPath: savedMediaList[index],
                        current_index: index,
                        downloadable: false)
                    : SingleVideo(
                        videoPath: savedMediaList[index],
                        current_index: index,
                        downloadable: false);
              },
            ),
          )
        : Center(
            child: Text(
                "No File Found \n Looks like you have not saved any file"));
  }

  Widget videos() {
    return imgList.length > 0
        ? Container(
            child: AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 5,
              itemCount: videoList.length,
              //reverse: true,
              itemBuilder: (context, index) {
                return SingleVideo(
                    videoPath: videoList[index],
                    current_index: index,
                    downloadable: false);
              },
            ),
          )
        : Center(child: Text("No Video Found"));
  }
}
