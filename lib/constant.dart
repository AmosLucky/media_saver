import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

var app_name = "Media Saver";
var primaryColor = Colors.teal[900];
var app_id = "com.mediasaver.com";
var app_link = "https://play.google.com/store/apps/details?id=" + app_id;
var appVersion = 2;
var iOSAppId = "";
var click_b4_ads = 3;
var folderName = "com.mediasaver.com";
goTo(BuildContext context, Widget child) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: child,
          duration: const Duration(milliseconds: 400)));
}
