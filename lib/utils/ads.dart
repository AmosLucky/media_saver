import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:staus_saver/constant.dart';

var _interstitialAd;
var _isInterstitialAdReady = false;

int add_count = 0;
void adCounter() {
  print("hhhh");
  if (add_count >= click_b4_ads) {
    add_count = 0;

    loadInterstitialAd();

    ///showMessage(context, "Ads", "Ads", 1);
    //print("add cont");
  } else {
    add_count++;
    //print(add_count);
  }
}

void loadInterstitialAd() {
  InterstitialAd.load(
    adUnitId: 'ca-app-pub-1378908943444559/1471252701',
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        _interstitialAd = ad;

        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            //Navigator.pop(context);
          },
        );

        _isInterstitialAdReady = true;
      },
      onAdFailedToLoad: (err) {
        print('Failed to load an interstitial ad: ${err.message}');
        _isInterstitialAdReady = false;
      },
    ),
  );
  _interstitialAd?.show();
}

showBannerAdd({required double height, required double width}) {
  InterstitialAd interstitialAd;
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-1378908943444559/4976766337',
    size: AdSize(width: width.toInt(), height: height.toInt()),
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  final AdWidget adWidget = AdWidget(ad: myBanner);
  myBanner.load();

  return Container(
    alignment: Alignment.center,
    child: adWidget,
    width: myBanner.size.width.toDouble(),
    height: myBanner.size.height.toDouble(),
  );
}
