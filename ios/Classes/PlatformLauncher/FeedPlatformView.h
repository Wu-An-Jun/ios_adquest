//
//  FeedPlatformView.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <iOS_AdQuestSDK/AdvanceNativeExpress.h>
#import <iOS_AdQuestSDK/AdvanceNativeExpressAd.h>
@interface FeedPlatformView : NSObject <FlutterPlatformView, AdvanceNativeExpressDelegate>
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
