import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:share/share.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:staus_saver/pages/home.dart';
import 'package:staus_saver/pages/splash_screen.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staus_saver/providers/satus_save.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //StatusSaver.createFolder();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.green[700],
        fontFamily: 'Georgia',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
