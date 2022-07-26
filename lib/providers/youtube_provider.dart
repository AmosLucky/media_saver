//import 'package:android_download_manager/android_download_manager.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:staus_saver/constant.dart';

class YoutubeProvider {
  Future<dynamic> downloadVideo(String youTube_link) async {
    final result = await FlutterYoutubeDownloader.downloadVideo(
        youTube_link, app_name, 18);

    // return result;
    print(result);
  }

  String? getIdFromUrl(String url) {
    final regex = RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false);

    try {
      if (regex.hasMatch(url)) {
        return regex.firstMatch(url)!.group(1);
      }
    } catch (e) {
      return null;
    }
  }

  String getYouTubeUrl(String content) {
    RegExp regExp = RegExp(
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?');
    String? matches = regExp.stringMatch(content);
    if (matches == null) {
      return 'null'; // Always returns here while the video URL is in the content paramter
    }
    final String youTubeUrl = matches;
    return youTubeUrl;
  }
}
