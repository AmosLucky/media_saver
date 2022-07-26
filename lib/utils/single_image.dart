import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:staus_saver/utils/ads.dart';
import 'package:staus_saver/utils/photo_view.dart';
import 'package:share_extend/share_extend.dart';

import '../constant.dart';

class SingleImage extends StatelessWidget {
  var imgPath;
  int current_index;
  bool downloadable;
  SingleImage(
      {Key? key,
      required this.imgPath,
      required this.current_index,
      required this.downloadable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        adCounter();
        goTo(
            context,
            PhotoView(
                current_index: current_index,
                imgPath: imgPath,
                downloadadble: downloadable));
        // var route = MaterialPageRoute(
        //     builder: (BuildContext) => PhotoView(
        //         current_index: current_index,
        //         imgPath: imgPath,
        //         downloadadble: downloadable));
        // Navigator.push(context, route);
      },
      child: Container(
        width: size.width / 2,
        height: size.height / 4,
        child: Hero(
            tag: imgPath,
            child: Stack(
              children: [
                Image.file(
                  File(imgPath),
                  fit: BoxFit.cover,
                  height: size.height / 4,
                  width: size.width / 2,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      adCounter();
                      ShareExtend.share(imgPath, "image");
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Icon(Icons.share),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
