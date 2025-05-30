//
//  FeedPlatformViewFactory.h
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface FeedPlatformViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
