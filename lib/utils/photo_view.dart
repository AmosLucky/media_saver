import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';
import 'package:staus_saver/providers/satus_save.dart';
import 'package:staus_saver/providers/whatsapp_provider.dart';
import 'package:staus_saver/utils/ads.dart';
import 'package:staus_saver/utils/fabs.dart';

class PhotoView extends StatefulWidget {
  int current_index;
  var imgPath;
  bool downloadadble;

  PhotoView(
      {Key? key,
      required this.current_index,
      required this.imgPath,
      required this.downloadadble})
      : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  WhatsappProvider whatsappProvider = WhatsappProvider();

  var imgList = [];

  void initState() {
    initialize();

    // TODO: implement initState
    super.initState();
  }

  initialize() async {
    imgList = await whatsappProvider.readImages();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showBannerAdd(
                height: 100, width: MediaQuery.of(context).size.width),
            Container(
              width: size.width,
              // height: size.,
              child: Image.file(
                File(widget.imgPath),
                //fit: BoxFit.cover,
                height: size.height / 1.8,
                width: size.width,
              ),
            ),
          ],
        ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        bottomNavigationBar: Fabs(
            file_type: "image",
            file_path: widget.imgPath,
            downloadable: widget.downloadadble));
  }
}
