//
//  BannerPlatformViewFactory.m
//  Pods
//
//  Created by admin on 2025/5/30.
//

#import "BannerPlatformViewFactory.h"
#import "BannerPlatformView.h"

@implementation BannerPlatformViewFactory {
    NSObject<FlutterBinaryMessenger>* _messenger;
}
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self = [super init];
    if (self) {
        _messenger = messenger;
    }
    return self;
}
- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                    viewIdentifier:(int64_t)viewId
                                         arguments:(id)args {
    return [[BannerPlatformView alloc] initWithFrame:frame
                                        viewIdentifier:viewId
                                             arguments:args
                                       binaryMessenger:_messenger];
}

-(NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}
@end
