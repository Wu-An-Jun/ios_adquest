//
//  InterstitialAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <iOS_AdQuestSDK/AdvanceInterstitial.h>

@interface InterstitialAdLauncher : NSObject <AdvanceInterstitialDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end
