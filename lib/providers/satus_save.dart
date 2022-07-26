import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:path_provider/path_provider.dart';
import 'package:staus_saver/constant.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart';

class StatusSaver {
  final app_folder = Directory("/storage/emulated/0/$folderName");
  // static folder_directory =
  createFolder() async {
    final path = Directory("/storage/emulated/0/$folderName");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");

      try {
        path.create();
      } catch (e) {
        getExternalStorageDirectory();
      }
    }
  }

  // createFolder2(BuildContext context) async {
  //   var externalDirectoryPath = await ExtStorage.getExternalStorageDirectory();
  // }

  // static String app_folder_dir =
  static Directory app_folder_dir() {
    //Initializer.createFolder();
    //final folderName = app_name;
    final path = Directory("/storage/emulated/0/$folderName");
    return path;
  }

  Future<bool> saveFile(String old_path, image_name) async {
    try {
      File result = await File(old_path)
          .copy('${StatusSaver.app_folder_dir().path}/' + image_name);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletFile(String old_path) async {
    try {
      await File(old_path).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  static showSnackBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  List<String> readImages() {
    var list_images = app_folder
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.jpg'))
        .toList(growable: false);
    list_images.reversed;
    return list_images;
  }

  List<String> readVideos() {
    var list_videos = app_folder
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.mp4'))
        .toList(growable: false);
    return list_videos;
  }

  List<String> readMedia() {
    var list_videos = app_folder
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.mp4') || item.endsWith('.jpg'))
        .toList(growable: false);
    return list_videos;
  }

  Future<List<String>> getDeviceDetails() async {
    String deviceName = "";
    String deviceVersion = "";
    String identifier = "";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model!;
        deviceVersion = build.version.toString();
        identifier = build.androidId!; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name!;
        deviceVersion = data.systemVersion!;
        identifier = data.identifierForVendor!; //UUID for iOS
      }
    } catch (e) {
      print('Failed to get platform version');
    }
    // print(deviceName + " " + deviceVersion + " " + identifier);
    // post([deviceName, identifier]);

//if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }

  showAlertDialogUPdate(
    BuildContext context,
    String title,
    String message,
  ) {
    // set up the button

    // show the dialog
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: primaryColor),
            ),
            content: Text(message),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  LaunchReview.launch(
                      androidAppId: "mediasaver.com", iOSAppId: "585027354");
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
