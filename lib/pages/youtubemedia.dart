import 'package:flutter/material.dart';
import 'package:staus_saver/pages/youtube_media.dart';
import 'package:staus_saver/providers/youtube_provider.dart';
import 'package:staus_saver/utils/ads.dart';

import '../constant.dart';

class YoutubeMedia extends StatefulWidget {
  const YoutubeMedia({Key? key}) : super(key: key);

  @override
  State<YoutubeMedia> createState() => _YoutubeMediaState();
}

class _YoutubeMediaState extends State<YoutubeMedia> {
  YoutubeProvider youtubeProvider = YoutubeProvider();
  var search_controller = TextEditingController();
  var error_message = "";
  //bool has_error = false;
  bool is_loading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showBannerAdd(height: 100, width: MediaQuery.of(context).size.width),
          Card(
            shape: StadiumBorder(),
            child: Container(
              width: size.width,
              child: Container(
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: search_controller,
                  decoration: InputDecoration(
                      label: Text("Paste youtbube video link"),
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
                  Text(
                    "Correct link format: https://www.youtube.com/watch?v=gUC3cbfrmX4 " +
                        "\n or \nyoutube.com/watch?v=gUC3cbfrmX4",
                    style: TextStyle(
                      color: Colors.green[900],
                    ),
                    textAlign: TextAlign.center,
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
                adCounter();
                startDownloading(search_controller.text);
              },
              child: Text("Start Downloading"),
              color: primaryColor,
              textColor: Colors.white,
              shape: StadiumBorder(),
            ),
          )
        ],
      ),
    );
  }

  startDownloading(String url) {
    url = url.trim().replaceAll(" ", "");
    error_message = "";
    if (search_controller.text.trim().length > 2) {
      String sanitized_link =
          youtubeProvider.getYouTubeUrl(search_controller.text);
      if (sanitized_link != 'null') {
        String? id = youtubeProvider.getIdFromUrl(url);
        if (id != null) {
          if (url.startsWith("youtube")) {
            url = "https://" + url;
          }
          var route = MaterialPageRoute(
              builder: (BuildContext) =>
                  DownloadFromYoutube(youtube_link: url, video_id: id));
          Navigator.push(context, route);
        } else {
          error_message = "Invalid link : " + url;
        }
      } else {
        error_message = "Invalid link : " + url;
      }
    } else {
      error_message = "Invalid youtube link";
    }
    setState(() {});
  }
}
