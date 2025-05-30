import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_adquest_platform_interface.dart';

/// An implementation of [IosAdquestPlatform] that uses method channels.
class MethodChannelIosAdquest extends IosAdquestPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_adquest');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override // 设置广告请求Url
  Future<void> setADSdkRequestUrl(String url) async {
    await methodChannel.invokeMethod('setADSdkRequestUrl', {'url': url});
  }

  @override
  Future<String?> showRewardVideoAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showRewardVideoAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> FullScreenVideo(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'FullScreenVideo',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showInterstitialAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showInterstitialAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showBannerAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showBannerAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showFullScreenVideoAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showFullScreenVideoAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showSplashAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showSplashAd',
      {'adspotId': adspotId},
    );
    return result;
  }

}
