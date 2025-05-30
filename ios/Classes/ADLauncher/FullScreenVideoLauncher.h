//
//  FullScreenVideoLauncher.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <iOS_AdQuestSDK/AdvanceFullScreenVideo.h>

@interface FullScreenVideoLauncher : NSObject <AdvanceFullScreenVideoDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end
