import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class WhatsappProvider {
  Directory odinary_watsapp = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
  Directory business_watsapp = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses');
  Directory gb_watsapp =
      Directory('/storage/emulated/0/GBWhatsApp/Media/.Statuses');
  Directory fm_watsapp = Directory(
      '/storage/emulated/0/Android/media/com.fmwhatsapp/FMWhatsApp/Media/FMWhatsApp_Statuses');

  String getAvailableWhatsapp() {
    if (odinary_watsapp.existsSync() && getLenght(odinary_watsapp) > 1) {
      return "1";
    } else if (business_watsapp.existsSync() &&
        getLenght(business_watsapp) > 1) {
      return "2";
    } else if (gb_watsapp.existsSync() && getLenght(gb_watsapp) > 1) {
      return "3";
    } else if (fm_watsapp.existsSync() && getLenght(fm_watsapp) > 1) {
      return "4";
    } else {
      return "1";
    }
  }

  int getLenght(Directory directory) {
    return directory.listSync().map((item) => item.path).length;
  }

  Future<Directory> switchWhatSappType() async {
    SharedPreferences sharedprefernce = await SharedPreferences.getInstance();
    String whatsapp_type = "1";
    if (sharedprefernce.getString("whatsapp_type") != null ||
        sharedprefernce.getString("whatsapp_type") == "") {
      whatsapp_type = sharedprefernce.getString("whatsapp_type")!;
    }
    if (whatsapp_type == "1") {
      return odinary_watsapp;
    } else if (whatsapp_type == "2") {
      return business_watsapp;
    } else if (whatsapp_type == "3") {
      return gb_watsapp;
    } else if (whatsapp_type == "4") {
      return fm_watsapp;
    }
    return odinary_watsapp;
  }

  Future<List<String>> readImages() async {
    final Directory _directory = await switchWhatSappType();
    var list_images = _directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.jpg'))
        .toList(growable: false);
    list_images.reversed;
    return list_images;
  }

  Future<List<String>> readVideos() async {
    final Directory _directory = await switchWhatSappType();
    var list_videos = _directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.mp4'))
        .toList(growable: false);
    list_videos.reversed;
    return list_videos;
  }

  Future<bool> chekWhatsAppExists() async {
    try {
      var directory = await switchWhatSappType();
      return directory.existsSync();
    } catch (e) {
      return false;
    }
  }
}
