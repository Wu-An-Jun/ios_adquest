
import 'ios_adquest_platform_interface.dart';
class IosAdquest {
  Future<String?> getPlatformVersion() {
    return IosAdquestPlatform.instance.getPlatformVersion();
  }

  // 设置广告请求Url
  Future<void> setADSdkRequestUrl(String url) {
    return IosAdquestPlatform.instance.setADSdkRequestUrl(url);
  }

  Future<String?> showRewardVideoAd(String adspotId) {
    return IosAdquestPlatform.instance.showRewardVideoAd(adspotId);
  }

  Future<String?> showInterstitialAd(String adspotId) {
    return IosAdquestPlatform.instance.showInterstitialAd(adspotId);
  }

  Future<String?> showBannerAd(String adspotId) {
    return IosAdquestPlatform.instance.showBannerAd(adspotId);
  }

  Future<String?> showFullScreenVideoAd(String adspotId) {
    return IosAdquestPlatform.instance.showFullScreenVideoAd(adspotId);
  }

  Future<String?> showSplashAd(String adspotId) {
    return IosAdquestPlatform.instance.showSplashAd(adspotId);
  }

}
