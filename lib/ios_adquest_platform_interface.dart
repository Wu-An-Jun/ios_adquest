import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_adquest_method_channel.dart';

abstract class IosAdquestPlatform extends PlatformInterface {
  /// Constructs a IosAdquestPlatform.
  IosAdquestPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosAdquestPlatform _instance = MethodChannelIosAdquest();

  /// The default instance of [IosAdquestPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosAdquest].
  static IosAdquestPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosAdquestPlatform] when
  /// they register themselves.
  static set instance(IosAdquestPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  // 设置广告请求Url
  Future<void> setADSdkRequestUrl(String url) {
    throw UnimplementedError('setADSdkRequestUrl() has not been implemented.');
  }

  Future<String?> showRewardVideoAd(String adspotId) {
    throw UnimplementedError('showRewardVideoAd(String adspotId) has not been implemented.');
  }


  @override
  Future<String?> showInterstitialAd(String adspotId) {
    throw UnimplementedError('showInterstitialAd(String adspotId) has not been implemented.');
  }

  @override
  Future<String?> showBannerAd(String adspotId) {
    throw UnimplementedError('showBannerAd(String adspotId) has not been implemented.');
  }

  @override
  Future<String?> showFullScreenVideoAd(String adspotId) {
    throw UnimplementedError('showFullScreenVideoAd(String adspotId) has not been implemented.');
  }

  @override
  Future<String?> showSplashAd(String adspotId) {
    throw UnimplementedError('showSplashAd(String adspotId) has not been implemented.');
  }

}
