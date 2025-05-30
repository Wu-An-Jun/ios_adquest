//
//  BannerPlatformView.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <iOS_AdQuestSDK/AdvanceBanner.h>

@interface BannerPlatformView : NSObject <FlutterPlatformView, AdvanceBannerDelegate>
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
