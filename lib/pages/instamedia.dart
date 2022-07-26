import 'package:flutter/material.dart';
import 'package:staus_saver/providers/insta_provider.dart';

import '../constant.dart';

class InstaMedia extends StatefulWidget {
  const InstaMedia({Key? key}) : super(key: key);

  @override
  State<InstaMedia> createState() => _InstaMediaState();
}

class _InstaMediaState extends State<InstaMedia> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            toolbarHeight: 0,
            //backgroundColor: Colors.redAccent,
            elevation: 0,
            // ignore: prefer_const_constructors
            bottom: TabBar(
                labelColor: primaryColor,
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
                      child: Text("Videos"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Images"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            cominingSoon(size),
            cominingSoon(size),
          ]),
        ));
  }

  Widget cominingSoon(Size size) {
    return Container(
      width: size.width,
      child: Image.asset("assets/images/coming_soon.jpg"),
    );
  }
}

class DownloadInsta extends StatefulWidget {
  String type;
  DownloadInsta({Key? key, required this.type}) : super(key: key);

  @override
  State<DownloadInsta> createState() => _DownloadInstaState();
}

class _DownloadInstaState extends State<DownloadInsta> {
  var insta_controller = TextEditingController();
  var insta_image_controller = TextEditingController();
  var error_message = "";
  //bool has_error = false;
  bool is_loading = false;
  InstaProvider instaProvider = InstaProvider();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          shape: StadiumBorder(),
          child: Container(
            width: size.width,
            child: Container(
              width: 100,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: insta_controller,
                decoration: InputDecoration(
                    label: Text("Paste instagram ${widget.type} link"),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          ),
        ),
        Visibility(visible: is_loading, child: LinearProgressIndicator()),
        Visibility(
            visible: error_message.length > 2,
            child: Column(
              children: [
                Text(
                  error_message,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Container(
          width: size.width / 2,
          child: MaterialButton(
            onPressed: () {
              // error_message = "";
              // var url = insta_controller.text.trim().replaceAll(" ", "");
              // if (url.length > 5) {
              //   if (url.contains("v")) {
              //     if (widget.type == "Videos") {
              //       instaProvider.save2();
              //       print("oo");
              //       instaProvider.downloadVideo(
              //           "https://www.instagram.com/reel/CJSlF7onjeU/?igshid=1ju3ngvjn3e8ndev_raushanjha");
              //     } else {
              //       instaProvider.downloadImage(
              //           "https://www.instagram.com/p/CKHG24Kj_Xy/?igshid=8tu91c0kghf7");
              //     }
              //     try {} catch (e) {
              //       error_message = e.toString();
              //     }
              //   } else {
              //     error_message = "invalid url";
              //   }
              // } else {
              //   error_message = "invalid url";
              // }
              // setState(() {});
              // // startDownloading(search_controller.text);
            },
            child: Text("Downloading ${widget.type}"),
            color: Colors.blueAccent,
            textColor: Colors.white,
            shape: StadiumBorder(),
          ),
        )
      ],
    );
  }
}
