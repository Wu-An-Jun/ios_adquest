/*
         /\_/\
        ( o.o )
         > ^ <   招财猫保佑，代码顺利
*/
package com.hczhhm.ios_adquest;
import android.app.Activity;
import androidx.annotation.NonNull;
import com.advance.AdvanceRewardVideo;
import com.advance.AdvanceRewardVideoItem;
import com.advance.AdvanceRewardVideoListener;
import com.advance.model.AdvanceError;
import com.advance.RewardServerCallBackInf;
import com.advance.AdvanceBanner;
import com.advance.AdvanceBannerListener;
import com.advance.AdvanceInterstitial;
import com.advance.AdvanceInterstitialListener;
import com.advance.AdvanceFullScreenVideo;
import com.advance.AdvanceFullScreenVideoListener;
import com.advance.AdvanceFullScreenItem;
import com.advance.AdvanceSplash;
import com.advance.AdvanceSplashListener;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.widget.FrameLayout;

import  com.advance.AdvanceConfig;

/** IosAdquestPlugin */
public class IosAdquestPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private MethodChannel channel;
  private Activity activity;

  public Activity getActivity() {
    return activity;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ios_adquest");
    channel.setMethodCallHandler(this);
    // 注册 Banner PlatformView，传递插件自身
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
      "my_banner_ad_view",
      new BannerAdPlatformViewFactory(this)
    );
    // 注册信息流 PlatformView，传递插件自身
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
      "my_feed_ad_view",
      new FeedAdPlatformViewFactory(this)
    );
    // 注册Draw信息流 PlatformView，传递插件自身
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
      "my_draw_ad_view",
      new DrawAdPlatformViewFactory(this)
    );
  }

  // ActivityAware相关方法
  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    // 移除 PlatformView 注册逻辑
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "setADSdkRequestUrl":
        // 设置url
        String url = call.argument("url");
        com.advance.AdvanceConfig.setAdvanceSdkRequestUrl(url);
        com.advance.AdvanceConfig.setAdvanceSdkRequestUrlHttps(url);
        result.success(null);
        break;
      case "showRewardVideoAd":
        // 这里写激励广告的逻辑
        if (activity == null) {
          result.error("NO_ACTIVITY", "Activity is null", null);
          return;
        }
        String rewardAdspotId = call.argument("adspotId");
        showRewardVideoAd(activity, rewardAdspotId, result);
        break;
      case "FullScreenVideo":
        String fullScreenAdspotId = call.argument("adspotId");
        // 这里写全屏视频广告的逻辑
        result.success("FullScreenVideo called with adspotId: " + fullScreenAdspotId);
        break;
      case "showInterstitialAd":
        String interstitialAdspotId = call.argument("adspotId");
        if (activity == null) {
          result.error("NO_ACTIVITY", "Activity is null", null);
          return;
        }
        showInterstitialAd(activity, interstitialAdspotId, result);
        break;
      case "showFullScreenVideoAd":
        String fullScreenVideoAdspotId = call.argument("adspotId");
        if (activity == null) {
          result.error("NO_ACTIVITY", "Activity is null", null);
          return;
        }
        showFullScreenVideoAd(activity, fullScreenVideoAdspotId, result);
        break;
      case "showSplashAd":
        String splashAdspotId = call.argument("adspotId");
        if (activity == null) {
          result.error("NO_ACTIVITY", "Activity is null", null);
          return;
        }
        showSplashAd(activity, splashAdspotId, result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void showRewardVideoAd(Activity activity, String adspotId, MethodChannel.Result result) {
    AdvanceRewardVideo advanceRewardVideo = new AdvanceRewardVideo(adspotId);
    advanceRewardVideo.setUserId("用户唯一标识"); // TODO: 替换为实际用户ID
    advanceRewardVideo.setExtraInfo("透传信息"); // TODO: 替换为实际透传信息
    advanceRewardVideo.setAdListener(new AdvanceRewardVideoListener() {
      @Override
      public void onAdLoaded(AdvanceRewardVideoItem item) {
        advanceRewardVideo.show(activity);
      }
      @Override
      public void onAdShow() {}
      @Override
      public void onAdFailed(AdvanceError error) {
        result.error("AD_LOAD_FAILED", error.msg, null);
      }
      @Override
      public void onAdClicked() {}
      @Override
      public void onVideoCached() {}
      @Override
      public void onVideoComplete() {}
      @Override
      public void onVideoSkip() {}
      @Override
      public void onAdClose() {
        result.success("ad_closed");
      }
      @Override
      public void onAdReward() {
        // 激励发放
      }
      @Override
      public void onRewardServerInf(RewardServerCallBackInf inf) {}
      @Override
      public void onSdkSelected(String id) {}
    });
    advanceRewardVideo.loadStrategy();
  }

  // 插屏广告
  private void showInterstitialAd(Activity activity, String adspotId, MethodChannel.Result result) {
    AdvanceInterstitial advanceInterstitial = new AdvanceInterstitial(activity, adspotId);
    advanceInterstitial.setAdListener(new AdvanceInterstitialListener() {
      @Override
      public void onAdReady() {
        advanceInterstitial.show();
      }
      @Override
      public void onAdClose() {
        result.success("interstitial_closed");
      }
      @Override
      public void onAdShow() {}
      @Override
      public void onAdFailed(AdvanceError advanceError) {
        result.error("INTERSTITIAL_LOAD_FAILED", advanceError.msg, null);
      }
      @Override
      public void onSdkSelected(String id) {}
      @Override
      public void onAdClicked() {}
    });
    advanceInterstitial.loadStrategy();
  }

  // Banner广告（注意：需要结合PlatformView实现ViewGroup容器，这里仅实现核心逻辑）


  // 全屏视频广告
  private void showFullScreenVideoAd(Activity activity, String adspotId, MethodChannel.Result result) {
    AdvanceFullScreenVideo advanceFullScreenVideo = new AdvanceFullScreenVideo(activity, adspotId);
    advanceFullScreenVideo.setAdListener(new AdvanceFullScreenVideoListener() {
      @Override
      public void onAdLoaded(AdvanceFullScreenItem item) {
        advanceFullScreenVideo.show();
      }
      @Override
      public void onAdClose() {
        result.success("fullscreen_closed");
      }
      @Override
      public void onVideoComplete() {}
      @Override
      public void onVideoSkipped() {}
      @Override
      public void onVideoCached() {}
      @Override
      public void onAdShow() {}
      @Override
      public void onAdFailed(AdvanceError advanceError) {
        result.error("FULLSCREEN_LOAD_FAILED", advanceError.msg, null);
      }
      @Override
      public void onSdkSelected(String id) {}
      @Override
      public void onAdClicked() {}
    });
    advanceFullScreenVideo.loadStrategy();
  }

  // 开屏广告
  private void showSplashAd(Activity activity, String adspotId, MethodChannel.Result result) {
    // 直接在当前 activity 启动开屏广告并展示
    FrameLayout adContainer = new FrameLayout(activity);
    activity.addContentView(adContainer, new FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT));
    AdvanceSplash advanceSplash = new AdvanceSplash(adspotId);
    advanceSplash.setAdListener(new AdvanceSplashListener() {
      @Override
      public void onSdkSelected(String id) {}
      @Override
      public void onAdLoaded() {
        advanceSplash.show(adContainer);
      }
      @Override
      public void jumpToMain() {
        // 不做页面跳转，直接关闭广告容器
        adContainer.removeAllViews();
        result.success("splash_closed");
      }
      @Override
      public void onAdShow() {}
      @Override
      public void onAdFailed(AdvanceError advanceError) {
        adContainer.removeAllViews();
        result.error("SPLASH_LOAD_FAILED", advanceError.msg, null);
      }
      @Override
      public void onAdClicked() {}
    });
    advanceSplash.loadOnly();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}