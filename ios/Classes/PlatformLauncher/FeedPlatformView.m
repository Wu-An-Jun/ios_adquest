//
//  FeedPlatformView.m
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import "FeedPlatformView.h"

@interface FeedPlatformView ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) AdvanceNativeExpress *advanceFeed;
@end

@implementation FeedPlatformView

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self = [super init];
    if (self) {
        _containerView = [[UIView alloc] initWithFrame:frame];
        NSString *adspotId = args[@"placementID"];
        UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
        CGSize adSize = CGSizeMake(0, 0); // 高度0自适应
        self.advanceFeed = [[AdvanceNativeExpress alloc] initWithAdspotId:adspotId customExt:nil viewController:rootVC adSize:adSize];
        self.advanceFeed.delegate = self;
        [self.advanceFeed loadAd];
    }
    return self;
}

- (UIView *)view {
    return _containerView;
}

#pragma mark - AdvanceNativeExpressDelegate

- (void)didFinishLoadingNativeExpressAds:(NSArray<AdvanceNativeExpressAd *> *)nativeAds spotId:(NSString *)spotId {
    // 只取第一个广告渲染
    if (nativeAds.count > 0) {
            AdvanceNativeExpressAd *nativeAd = nativeAds.firstObject;
            UIView *adView = [nativeAd expressView];
            // 先让adView布局完成
            [adView layoutIfNeeded];
            CGFloat adHeight = adView.frame.size.height;
            // 更新containerView高度
            CGRect frame = self.containerView.frame;
            frame.size.height = adHeight;
            self.containerView.frame = frame;
            adView.frame = CGRectMake(0, 0, frame.size.width, adHeight);
            // 清空旧广告
            [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.containerView addSubview:adView];
        }
}

- (void)nativeExpressAdViewRenderSuccess:(AdvanceNativeExpressAd *)nativeAd spotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 渲染成功后可做额外处理
}

- (void)nativeExpressAdViewRenderFail:(AdvanceNativeExpressAd *)nativeAd spotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 渲染失败处理
}

- (void)didShowNativeExpressAd:(AdvanceNativeExpressAd *)nativeAd spotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 曝光回调
}

- (void)didClickNativeExpressAd:(AdvanceNativeExpressAd *)nativeAd spotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 点击回调
}

- (void)didCloseNativeExpressAd:(AdvanceNativeExpressAd *)nativeAd spotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 广告关闭，移除视图
    [[nativeAd expressView] removeFromSuperview];
}

@end
