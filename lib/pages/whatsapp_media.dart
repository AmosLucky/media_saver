import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staus_saver/providers/whatsapp_provider.dart';
import 'package:staus_saver/utils/ads.dart';
import 'package:staus_saver/utils/single_image.dart';
import 'package:staus_saver/utils/single_video.dart';

import '../constant.dart';

class WhatsAppMedia extends StatefulWidget {
  const WhatsAppMedia({Key? key}) : super(key: key);

  @override
  State<WhatsAppMedia> createState() => _WhatsAppMediaState();
}

class _WhatsAppMediaState extends State<WhatsAppMedia> {
  WhatsappProvider whatsappProvider = new WhatsappProvider();
  var imgList = [];
  var videoList = [];
  bool dirExists = true;
  bool showSetting = false;
  @override
  void initState() {
    initialize();

    // TODO: implement initState
    super.initState();
  }

  initialize() async {
    dirExists = await whatsappProvider.chekWhatsAppExists();
    setState(() {});
    if (dirExists) {
      imgList = await whatsappProvider.readImages();
      videoList = await whatsappProvider.readVideos();
    } else {
      showSetting = true;
      dirExists = false;
    }

    setState(() {});

    //print(videoList);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 0,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: primaryColor,
            labelColor: primaryColor!,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Images",
                    style: TextStyle(fontFamily: "Georgia"),
                  ),
                ),
                //icon: Icon(Icons.image),
                // text: "Images",
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Videos",
                    style: TextStyle(fontFamily: "Georgia"),
                  ),
                ),
                //icon: Icon(Icons.video_camera_back),
                //text: "Videos",
              ),
            ],
          ),
        ),
        body: dirExists
            ? TabBarView(
                children: [images(), videos()],
              )
            : Center(
                child: InkWell(
                    onTap: () {
                      adCounter();
                    },
                    child: Text(
                      "Please select your whatsapp type from the settings below to start seeing your friends status",
                      textAlign: TextAlign.center,
                    )),
              ),
        floatingActionButton: SpeedDial(
          icon: Icons.settings,
          activeIcon: Icons.close,
          visible: true,
          isOpenOnStart: showSetting,
          overlayColor: Colors.transparent,
          overlayOpacity: 0.05,
          // animatedIcon: AnimatedIcons.view_list,
          closeDialOnPop: false,
          child: Icon(Icons.settings),
          children: [
            SpeedDialChild(
              child: Image.asset("assets/images/normal.png"),
              label: 'Main WhatsApp',
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString("whatsapp_type", "1");
                initialize();
                setState(() {});
              },
            ),
            SpeedDialChild(
              child: Image.asset("assets/images/business.png"),
              label: 'Business WhatsApp',
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString("whatsapp_type", "2");
                initialize();
                setState(() {});
              },
            ),
            SpeedDialChild(
              child: Image.asset("assets/images/gb.png"),
              label: 'GB WhatsApp',
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString("whatsapp_type", "3");
                initialize();
                setState(() {});
              },
            ),
            SpeedDialChild(
              child: Image.asset("assets/images/fm.png"),
              label: 'FM WhatsApp',
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString("whatsapp_type", "4");
                initialize();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget images() {
    if (imgList == 0) {
      setState(() {
        showSetting = true;
      });
    }
    return imgList.length > 0
        ? Container(
            child: AlignedGridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 5,
              itemCount: imgList.length,
              //reverse: true,
              itemBuilder: (context, index) {
                return SingleImage(
                    imgPath: imgList[index],
                    current_index: index,
                    downloadable: true);
              },
              // staggeredTileBuilder: (index) {
              //   return StaggeredTile.count(
              //       index % 7 == 0 ? 2 : 1, index % 7 == 0 ? 2 : 1);
              // },
            ),
          )
        : Center(
            child: Text(
            "No File Found\n Please select your whatsapp type from the settings",
            textAlign: TextAlign.center,
          ));
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
                    downloadable: true);
              },
              // staggeredTileBuilder: (index) {
              //   return StaggeredTile.count(
              //       index % 7 == 0 ? 2 : 1, index % 7 == 0 ? 2 : 1);
              // },
            ),
          )
        : Center(
            child: Text(
            "No Video Found. \n Please select your whatsapp type from the setting",
            textAlign: TextAlign.center,
          ));
  }
}
