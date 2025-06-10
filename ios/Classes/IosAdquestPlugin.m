#import "IosAdquestPlugin.h"
#import <iOS_AdQuestSDK/AdvanceRewardVideo.h>
#import <iOS_AdQuestSDK/AdvSdkConfig.h>


#import "RewardVideoAdLauncher.h"
#import "FullScreenVideoLauncher.h"
#import "SplashAdLauncher.h"
#import "InterstitialAdLauncher.h"
#import "BannerPlatformViewFactory.h"
#import "FeedPlatformViewFactory.h"

@implementation IosAdquestPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ios_adquest"
            binaryMessenger:[registrar messenger]];
  IosAdquestPlugin* instance = [[IosAdquestPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
    
    // 注册Banner PlatformView
     BannerPlatformViewFactory *factory = [[BannerPlatformViewFactory alloc] initWithMessenger:[registrar messenger]];
     [registrar registerViewFactory:factory withId:@"my_banner_ad_view"];
    
    // 注册Feed PlatformView
    FeedPlatformViewFactory *feedFactory = [[FeedPlatformViewFactory alloc] initWithMessenger:[registrar messenger]];
    [registrar registerViewFactory:feedFactory withId:@"my_feed_ad_view"];

}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"setADSdkRequestUrl" isEqualToString:call.method]) {
    // 设置广告请求URL
    NSString *url = call.arguments[@"url"];
    [AdvSdkConfig shareInstance].requestUrl = url;
    result(@(YES));
  } else if ([@"showRewardVideoAd" isEqualToString:call.method]) {
    // 激励广告
    NSString *adspotId = call.arguments[@"adspotId"];
    [[RewardVideoAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
    result(@"已开始加载激励视频广告");
  } else if ([@"showInterstitialAd" isEqualToString:call.method]) {
    // 插屏广告
    NSString *adspotId = call.arguments[@"adspotId"];

    [[InterstitialAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
    result(@"已开始加载插屏广告");
  }  else if ([@"showFullScreenVideoAd" isEqualToString:call.method]) {
    // 全屏视频广告
    NSString *adspotId = call.arguments[@"adspotId"];
     [[FullScreenVideoLauncher shared] showFromRootVCWithAdspotId:adspotId];
    result(@"已开始加载全屏视频广告");
  } else if ([@"showSplashAd" isEqualToString:call.method]) {
    // 开屏广告
    NSString *adspotId = call.arguments[@"adspotId"];
    [[SplashAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
    result(@"已开始加载开屏广告");
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
