//
//  SplashAdLauncher.m
//  Pods
//
//  Created by admin on 2025/5/30.
//


#import "SplashAdLauncher.h"
#import <UIKit/UIKit.h>
#import <iOS_AdQuestSDK/AdvanceSplash.h>

@interface SplashAdLauncher () <AdvanceSplashDelegate>
@property (nonatomic, strong) AdvanceSplash *advanceSplash;
@property (nonatomic, strong) UIImageView *bgImgV;
@end

@implementation SplashAdLauncher

+ (instancetype)shared {
    static SplashAdLauncher *ins;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[SplashAdLauncher alloc] init];
    });
    return ins;
}

- (void)showFromRootVCWithAdspotId:(NSString *)adspotId {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    if (self.advanceSplash) {
        self.advanceSplash.delegate = nil;
        self.advanceSplash = nil;
    }
    
    self.advanceSplash = [[AdvanceSplash alloc] initWithAdspotId:adspotId
                                                      customExt:nil
                                                viewController:rootVC];
    self.advanceSplash.delegate = self;
    [self.advanceSplash loadAd];
}

#pragma mark - AdvanceSplashDelegate

- (void)didFinishLoadingADPolicyWithSpotId:(NSString *)spotId {
    NSLog(@"开屏广告策略加载成功 spotId: %@", spotId);
}

- (void)didFailLoadingADSourceWithSpotId:(NSString *)spotId error:(NSError *)error description:(NSDictionary *)description {
    NSLog(@"开屏广告加载失败 spotId: %@, error: %@, description: %@", spotId, error, description);
}

- (void)didStartLoadingADSourceWithSpotId:(NSString *)spotId sourceId:(NSString *)sourceId {
    NSLog(@"开屏广告源开始加载 spotId: %@, sourceId: %@", spotId, sourceId);
}

- (void)didFinishLoadingSplashADWithSpotId:(NSString *)spotId {
    NSLog(@"开屏广告加载成功 spotId: %@", spotId);
    [self.advanceSplash showInWindow:[UIApplication sharedApplication].delegate.window];
}

- (void)splashDidShowForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"开屏广告展示成功 spotId: %@", spotId);
}

- (void)splashDidClickForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"开屏广告被点击 spotId: %@", spotId);
}

- (void)splashDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"开屏广告关闭 spotId: %@", spotId);
    self.advanceSplash.delegate = nil;
    self.advanceSplash = nil;
}

@end
