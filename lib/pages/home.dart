import 'dart:async';
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:staus_saver/constant.dart';
import 'package:staus_saver/pages/downloads.dart';
import 'package:staus_saver/pages/instamedia.dart';
import 'package:staus_saver/pages/whatsapp_media.dart';
import 'package:staus_saver/pages/youtube_media.dart';
import 'package:staus_saver/pages/youtubemedia.dart';
import 'package:staus_saver/providers/satus_save.dart';
import 'package:staus_saver/providers/whatsapp_provider.dart';
import 'package:staus_saver/utils/bottom_nav.dart';
import 'package:staus_saver/utils/permision_dialog.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WhatsappProvider whatsappProvider = WhatsappProvider();
  bool isPermited = true;
  var tab_name = "Whatsapp  Saver";

  int exit = 0;

  void checkPermission() async {
    final serviceStatus = await Permission.storage;
    bool isGpsOn = serviceStatus == ServiceStatus.enabled;
    //var p = await checkP();
    if (isGpsOn) {
      isPermited = true;
      print("granted");
      // go_home();
    } else {
      isPermited = false;
      print("not granted");
      requestPermission();
    }
  }

  void requestPermission() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      StatusSaver().createFolder();
      print('Permission granted');
      isPermited = true;
      setState(() {});
    } else if (status == PermissionStatus.denied) {
      showPermissionDialog(
          context: context,
          subject: "Grant Permission!",
          message: "${app_name} needs storage permision to function properly");
      print(
          'Denied. Show a dialog with a reason and again ask for the permission.');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      showPermissionDialog(
          context: context,
          subject: "Grant Permission!",
          message: "${app_name} needs storage permision to function properly");
    }
  }

  Future<bool> returnBackPress() async {
    // loadInterstitialAd();
    //startAdsCounter();
    if (exit < 1) {
      exit++;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Double tap  to exit")));
      Timer(Duration(seconds: 2), () {
        exit = 0;
        setState(() {});
      });

      setState(() {});
      return false;
    } else {
      SystemNavigator.pop();
      exit = 0;
      return false;
    }
  }

  @override
  void initState() {
    checkPermission();
    fetchCount();
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        tab_name = "Whatsapp Saver";
      }
      // else if (index == 1) {
      //   tab_name = "Youtube Saver";
      // }
      else if (index == 1) {
        tab_name = "Instagram Saver";
      } else {
        tab_name = "Saved Files";
      }
    });
  }

  fetchCount() async {
    try {
      var deviveDetails = await StatusSaver().getDeviceDetails();
      var request = await http.post(
          Uri.parse("http://mediasaver.unlimitedsub.com/settings/index.php"),
          body: {"version": deviveDetails[0], "devicename": deviveDetails[1]});

      if (request.statusCode == 200) {
        var res = jsonDecode(request.body);
        var version = res["current_version"];
        var cba = res["click_b4_ads"];
        click_b4_ads = cba;

        setState(() {});

        if (appVersion < version) {
          /////////new version/////
          StatusSaver().showAlertDialogUPdate(context, "New Version",
              "A new version of this app is now available on playstore, please install it to enjoy new features and better service");
        }
      }
    } catch (e) {
      print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    }
  }

  var pages = [
    WhatsAppMedia(),
    // YoutubeMedia(),
    InstaMedia(), Downloads()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => returnBackPress(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            tab_name,
            style: TextStyle(fontFamily: "Raleway", fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  shareApp();
                },
                icon: Icon(Icons.share))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Container(
                    color: primaryColor,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset("assets/images/whatsapp.png"),
                    ),
                  )),
              item("Share App", Icons.share, () {
                shareApp();
              }),
              item("Rate Us", Icons.star_rate, () {
                LaunchReview.launch(androidAppId: app_id, iOSAppId: iOSAppId);
              }),
              item("Update App", Icons.upload, () {
                LaunchReview.launch(androidAppId: app_id, iOSAppId: iOSAppId);
              })
            ],
          ),
        ),
        body: pages[_selectedIndex],

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: primaryColor!,
          items: <Widget>[
            imageMenu("assets/images/whatsapp.png"),
            // menu(Icons.video_library_sharp),
            imageMenu("assets/images/instagram2.png"),
            menu(Icons.download)
          ],
          onTap: (index) {
            _onItemTapped(index);
            //Handle button tap
          },
        ),
        // MyBottomNav(currentIndex: currentIndex, controller: _controller),
      ),
    );
  }

  Widget menu(IconData icon) {
    return Icon(
      icon,
      size: 30,
      color: Colors.white,
    );
  }

  Widget imageMenu(String path) {
    return Image.asset(
      path,
      height: 30,
      width: 50,
      color: Colors.white,
    );
  }

  Widget item(String title, IconData icon, Function onCliked) {
    return InkWell(
      onTap: () {
        onCliked;
      },
      child: ListTile(
        leading: Icon(
          icon,
          color: primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: "Georgia"),
        ),
      ),
    );
  }

  void shareApp() {
    Share.share("Hello dear😊, install ${app_name}" +
        "\n to start downloading images and videos from Whatsapp," +
        " Youtube, Instagram etc \n App link 👉👉 ${app_link}");
  }
}
