import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_helper.dart';

class ComponentAds extends StatefulWidget {
  const ComponentAds({Key? key}) : super(key: key);

  @override
  State<ComponentAds> createState() => _ComponentAdsState();
}

class _ComponentAdsState extends State<ComponentAds> {
  late BannerAd _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    _ad = BannerAd(
      size: AdSize.banner,
      request: AdRequest(),
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (_, error) {
          print('Ad Failed to load with Error: ${error.message}');
          _isLoaded = false;
          _ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (_) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (_) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (_) => print('Ad impression.'),
      ),
    );

    _ad.load();
    super.initState();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  Widget CheckForAd() {
    if (_isLoaded == true) {
      return Container(
        child: AdWidget(
          ad: _ad,
        ),
        width: _ad.size.width.toDouble(),
        height: _ad.size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckForAd();
  }
}
