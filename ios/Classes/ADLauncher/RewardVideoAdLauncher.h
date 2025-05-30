//
//  RewardVideoAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <iOS_AdQuestSDK/AdvanceRewardVideo.h>

@interface RewardVideoAdLauncher : NSObject <AdvanceRewardedVideoDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end

