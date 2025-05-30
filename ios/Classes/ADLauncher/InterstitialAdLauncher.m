//
//  InterstitialAdLauncher.m
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import "InterstitialAdLauncher.h"
#import <UIKit/UIKit.h>
#import <iOS_AdQuestSDK/AdvanceInterstitial.h>

@interface InterstitialAdLauncher () <AdvanceInterstitialDelegate>
@property (nonatomic, strong) AdvanceInterstitial *advanceInterstitial;
@end

@implementation InterstitialAdLauncher

+ (instancetype)shared {
    static InterstitialAdLauncher *ins;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[InterstitialAdLauncher alloc] init];
    });
    return ins;
}

- (void)showFromRootVCWithAdspotId:(NSString *)adspotId {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if (self.advanceInterstitial) {
        self.advanceInterstitial.delegate = nil;
        self.advanceInterstitial = nil;
    }
    
    self.advanceInterstitial = [[AdvanceInterstitial alloc] initWithAdspotId:adspotId
                                                                  customExt:nil
                                                             viewController:rootVC];
    self.advanceInterstitial.delegate = self;
    [self.advanceInterstitial loadAd];
}

#pragma mark - AdvanceInterstitialDelegate

- (void)didFinishLoadingADPolicyWithSpotId:(NSString *)spotId {
    NSLog(@"插屏广告策略加载成功 spotId: %@", spotId);
}

- (void)didFailLoadingADSourceWithSpotId:(NSString *)spotId error:(NSError *)error description:(NSDictionary *)description {
    NSLog(@"插屏广告加载失败 spotId: %@, error: %@, description: %@", spotId, error, description);
}

- (void)didStartLoadingADSourceWithSpotId:(NSString *)spotId sourceId:(NSString *)sourceId {
    NSLog(@"插屏广告源开始加载 spotId: %@, sourceId: %@", spotId, sourceId);
}

- (void)didFinishLoadingInterstitialADWithSpotId:(NSString *)spotId {
    NSLog(@"插屏广告加载成功 spotId: %@", spotId);
    [self.advanceInterstitial showAd];
}

- (void)interstitialDidShowForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"插屏广告展示成功 spotId: %@", spotId);
}

- (void)interstitialDidClickForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"插屏广告被点击 spotId: %@", spotId);
}

- (void)interstitialDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"插屏广告关闭 spotId: %@", spotId);
    self.advanceInterstitial.delegate = nil;
    self.advanceInterstitial = nil;
}

@end
