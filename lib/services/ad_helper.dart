import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // real ads id : 'ca-app-pub-9727420285169366/8005334484';
      // return test 'ca-app-pub-3940256099942544/6300978111';
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9727420285169366/5785261608';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
