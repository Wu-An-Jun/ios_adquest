//
//  BannerPlatformView.m
//  Pods
//
//  Created by admin on 2025/5/30.
//

//
//  MyBannerPlatformView..m
//  Pods
//
//  Created by admin on 2025/5/27.
//

#import "BannerPlatformView.h"

@interface BannerPlatformView ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) AdvanceBanner *advanceBanner;
@end

@implementation BannerPlatformView

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self = [super init];
    if (self) {
        _containerView = [[UIView alloc] initWithFrame:frame];
        NSString *adspotId = args[@"placementID"];
        
        UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
        self.advanceBanner = [[AdvanceBanner alloc] initWithAdspotId:adspotId adContainer:_containerView customExt:nil viewController:rootVC];
        self.advanceBanner.delegate = self;
        self.advanceBanner.refreshInterval = 30;
        [self.advanceBanner loadAd];
    }
    return self;
}
// 返回原生UIView给Flutter进行渲染
- (UIView *)view {
    return _containerView;
}

- (void)didFinishLoadingBannerADWithSpotId:(NSString *)spotId {
    [self.advanceBanner showAd];
}

- (void)bannerView:(UIView *)bannerView didCloseAdWithSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    [bannerView removeFromSuperview];
}

@end
