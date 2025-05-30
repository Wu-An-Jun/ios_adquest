//
//  FullScreenVideoLauncher.m
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import "FullScreenVideoLauncher.h"
#import <UIKit/UIKit.h>

// 匿名扩展，声明私有属性和方法，防止外部访问
@interface FullScreenVideoLauncher ()
// 当前全屏广告对象，生命周期由本类统一管理
@property (nonatomic, strong) AdvanceFullScreenVideo *advanceFullScreenVideo; // 声明全屏广告对象
@property (nonatomic) bool isAdLoaded; // 看是否缓存完毕
@end

@implementation FullScreenVideoLauncher

/// 获取全局唯一实例，保证广告管理全局唯一
+ (instancetype)shared {
    static FullScreenVideoLauncher *ins;
    static dispatch_once_t onceToken;
    // dispatch_once保证多线程环境下只初始化一次
    dispatch_once(&onceToken, ^{
        ins = [[FullScreenVideoLauncher alloc] init];
    });
    return ins;
}

/// 从根视图控制器展示全屏广告
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    self.advanceFullScreenVideo = [[AdvanceFullScreenVideo alloc] initWithAdspotId:adspotId customExt:nil viewController:rootVC];
    self.advanceFullScreenVideo.delegate = self;
    [self.advanceFullScreenVideo loadAd];
}

#pragma mark - 广告回调（需实现AdvanceFullScreenVideoDelegate协议）

/// 广告缓存成功后自动展示
/// @param spotId 当前广告位ID
/// @param extra  额外信息（如广告平台返回的扩展数据）
/// 全屏视频缓存成功
- (void)fullscreenVideoDidDownLoadForSpotId:(NSString *)spotId extra:(NSDictionary *)extra{
    // 判断广告对象有效性，防止因提前释放或加载失败导致崩溃
    if (self.advanceFullScreenVideo.isAdValid) {
        [self.advanceFullScreenVideo showAd];
    } else {
        // 广告无效，可能因超时、被回收等原因
        NSLog(@"广告无效，无法展示");
    }
}

/// 广告关闭后释放对象，防止内存泄漏
/// @param spotId 当前广告位ID
/// @param extra  额外信息
- (void)fullscreenVideoDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 断开代理，防止回调野指针
    self.advanceFullScreenVideo.delegate = nil;
    // 释放广告对象，保证下次可重新加载
    self.advanceFullScreenVideo = nil;
}

@end
