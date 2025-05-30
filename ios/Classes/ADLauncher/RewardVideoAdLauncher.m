//
//  RewardVideoAdLauncher.m
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import "RewardVideoAdLauncher.h"
#import <UIKit/UIKit.h>

// 匿名扩展，声明私有属性和方法，防止外部访问
@interface RewardVideoAdLauncher ()
// 当前激励视频广告实例，生命周期由本类统一管理
@property (nonatomic, strong) AdvanceRewardVideo *advanceRewardVideo;
@end

@implementation RewardVideoAdLauncher

#pragma mark - 单例实现

/// 获取全局唯一实例，保证广告管理全局唯一
+ (instancetype)shared {
    static RewardVideoAdLauncher *ins;
    static dispatch_once_t onceToken;
    // dispatch_once保证多线程环境下只初始化一次
    dispatch_once(&onceToken, ^{
        ins = [[RewardVideoAdLauncher alloc] init];
    });
    return ins;
}

#pragma mark - 广告加载与展示

/// 从根视图控制器展示激励视频广告
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    self.advanceRewardVideo = [[AdvanceRewardVideo alloc] initWithAdspotId:adspotId customExt:nil viewController:rootVC];
    self.advanceRewardVideo.delegate = self;
    [self.advanceRewardVideo loadAd];
}

#pragma mark - 广告回调（需实现AdvanceRewardVideoDelegate协议）

/// 广告缓存成功后自动展示
/// @param spotId 当前广告位ID
/// @param extra  额外信息（如广告平台返回的扩展数据）
- (void)rewardedVideoDidDownLoadForSpotId:(NSString *)spotId extra:(NSDictionary *)extra{
    // 判断广告对象有效性，防止因提前释放或加载失败导致崩溃
    if (self.advanceRewardVideo.isAdValid) {
        // 展示广告，通常为全屏弹窗
        [self.advanceRewardVideo showAd];
    } else {
        // 广告无效，可能因超时、被回收等原因
        NSLog(@"广告无效，无法展示");
    }
}

/// 广告关闭后释放对象，防止内存泄漏
/// @param spotId 当前广告位ID
/// @param extra  额外信息
- (void)rewardedVideoDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 断开代理，防止回调野指针
    self.advanceRewardVideo.delegate = nil;
    // 释放广告对象，保证下次可重新加载
    self.advanceRewardVideo = nil;
}

@end
