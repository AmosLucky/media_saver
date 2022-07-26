import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staus_saver/constant.dart';
import 'package:staus_saver/pages/home.dart';
import 'package:staus_saver/pages/my_home.dart';
import 'package:staus_saver/providers/satus_save.dart';
import 'package:staus_saver/providers/whatsapp_provider.dart';
import 'package:staus_saver/utils/permision_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasPermision = false;
  void checkPermission() async {
    final serviceStatus = await Permission.storage;
    bool isGpsOn = serviceStatus == ServiceStatus.enabled;
    //var p = await checkP();
    if (isGpsOn) {
      hasPermision = true;
      setState(() {});
      // go_home();
    }
  }

  saveWhatsappType() async {
    SharedPreferences sharedprefernce = await SharedPreferences.getInstance();
    if (sharedprefernce.getString("whatsapp_type") != null ||
        sharedprefernce.getString("whatsapp_type") == "") {
      sharedprefernce.setString(
          "whatsapp_type", WhatsappProvider().getAvailableWhatsapp());
    }
  }

  void requestPermission() async {
    print('pp');
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      StatusSaver().createFolder();
      go_home();
      //print(";;;");

      setState(() {});
    } else if (status == PermissionStatus.denied) {
      showPermissionDialog(
          context: context,
          subject: "Grant Permission!",
          message: "${app_name} needs storage permision to function properly",
          type: 1);

      print(
          'Denied. Show a dialog with a reason and again ask for the permission.');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      showPermissionDialog(
          context: context,
          subject: "Grant Permission!",
          message: "${app_name} needs storage permision to function properly," +
              "\nplease grant permision and restart the app",
          type: 2);
    }
  }

  void go_home() {
    goTo(context, Home());
    // var route = MaterialPageRoute(builder: (BuildContext) => Home());
    // Navigator.push(context, route);
  }

  void splashDone() {
    Timer(
        Duration(
          seconds: 3,
        ), () {
      if (hasPermision) {
        go_home();
      } else {
        requestPermission();
      }
    });
  }

  @override
  void initState() {
    saveWhatsappType();
    checkPermission();
    splashDone();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 50,
              ),
              Text(
                app_name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Raleway",
                    fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPermissionDialog(
      {required BuildContext context,
      String? subject,
      String? message,
      int? type}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        //Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Grant Permission"),
      onPressed: () {
        if (type! == 1) {
          requestPermission();
        } else {
          openAppSettings();
          comfirmPermison(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(subject!),
      content: Text(message!),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  comfirmPermison(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        checkPermission();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Permission"),
      content: Text("Confirm that you have allowed access to storage."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
