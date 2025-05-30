//
//  SplashAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <iOS_AdQuestSDK/AdvanceSplash.h>

@interface SplashAdLauncher : NSObject <AdvanceSplashDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end 
