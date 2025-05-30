import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// 用于展示平台原生信息流广告的Widget
class PlatformFeedWidget extends StatefulWidget {
  /// 构造函数，必须传入placementID，sceneID为可选参数
  const PlatformFeedWidget(this.placementID, {this.sceneID, Key? key}) : super(key: key);
  /// 广告位ID，必传参数
  final String placementID;
  /// 场景ID，可选参数
  final String? sceneID;

  @override
  _PlatformFeedWidgetState createState() => _PlatformFeedWidgetState();
}

class _PlatformFeedWidgetState extends State<PlatformFeedWidget> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        key: UniqueKey(),
        viewType: 'my_feed_ad_view',
        creationParams: <String, dynamic>{
          "placementID": widget.placementID,
          "sceneID": widget.sceneID,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        key: UniqueKey(),
        viewType: "my_feed_ad_view",
        creationParams: <String, dynamic>{
          "placementID": widget.placementID,
          "sceneID": widget.sceneID,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return const Text("Unsupported platform");
    }
  }
} 