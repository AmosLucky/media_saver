import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share_extend/share_extend.dart';
import 'package:staus_saver/providers/satus_save.dart';
import 'package:staus_saver/utils/ads.dart';

class Fabs extends StatelessWidget {
  var file_path;
  var file_type;
  bool downloadable;
  Fabs(
      {Key? key,
      required this.file_type,
      required this.file_path,
      required this.downloadable})
      : super(key: key);
  StatusSaver statusSaver = StatusSaver();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SpeedDial(
          visible: true,
          isOpenOnStart: true,
          overlayColor: Colors.transparent,
          overlayOpacity: 0.05,
          animatedIcon: AnimatedIcons.menu_close,
          closeDialOnPop: false,
          children: [
            downloadable
                ? SpeedDialChild(
                    child: Icon(Icons.download, color: Colors.pinkAccent),
                    label: "Save",
                    onTap: () async {
                      adCounter();
                      var imgName = file_path.split("/").last;
                      // File jpeg = await File(
                      //      '${Initializer.app_folder_dir().path}/' + imgName)
                      //  .create();
                      var result =
                          await statusSaver.saveFile(file_path, imgName);
                      if (result) {
                        StatusSaver.showSnackBar(context, "Successfully Saved");
                      } else {
                        StatusSaver.showSnackBar(context, "Failed to Saved");
                      }
                    })
                : SpeedDialChild(
                    // child: Icon(Icons.delete, color: Colors.pinkAccent),
                    // label: "Delete",
                    // onTap: () async {
                    //   var result = await statusSaver.deletFile(file_path);
                    //   if (result) {
                    //     StatusSaver.showSnackBar(
                    //         context, "Successfully Deleted");
                    //     Navigator.pop(context);

                    //   } else {
                    //     StatusSaver.showSnackBar(context, "Failed to Delete");
                    //   }
                    // }
                    ),
            SpeedDialChild(
                child: Icon(Icons.share, color: Colors.pinkAccent),
                label: "Share",
                onTap: () {
                  adCounter();
                  ShareExtend.share(file_path, file_type);
                  // sharePosts(content) async {
                  // Share.share(
                  //     " 😱 Hi friend, Install Live Football Stream Tv App and enjoy all Football matches free on your mobile in your comfort zone  😱😱 \n 👇👇👇 Click on the link \n" +
                  //         "https://play.google.com/store/apps/details?id=lucky_live_football_tv.com");
                  // final FlutterShareMe flutterShareMe = FlutterShareMe();
                  // var response = await flutterShareMe.shareToSystem(msg: msg);
                  // }
                }),
            // SpeedDialChild(
            //     child: Icon(
            //       Icons.reply,
            //       color: Colors.pinkAccent,
            //     ),
            //     label: "Repost",
            //     onTap: () {
            //       ShareExtend.share(file_path, file_type);
            //       // LaunchReview.launch(
            //       //     androidAppId: "lucky_live_football_tv.com",
            //       //     iOSAppId: "585027354");
            //     })
          ],
        ),
      ],
    );
  }
}
