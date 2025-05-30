// 引入Flutter的Cupertino库，主要用于iOS风格的UI组件（如CupertinoButton等），本例未直接用到，但可用于后续扩展iOS风格界面
import 'package:flutter/cupertino.dart';

// 引入Flutter的基础工具库，提供了平台判断（如defaultTargetPlatform）、调试等功能
import 'package:flutter/foundation.dart';

// 引入Flutter与原生平台通信相关的库，包含MethodChannel、PlatformView等
import 'package:flutter/services.dart';

// 定义一个用于展示平台原生Banner广告的Widget
class PlatformBannerWidget extends StatefulWidget {
  // 构造函数，必须传入placementID，sceneID为可选参数
  PlatformBannerWidget(this.placementID, {this.sceneID});
  // 广告位ID，必传参数
  final String placementID;
  // 场景ID，可选参数，用于区分广告场景
  final String? sceneID;
  // 创建对应的State对象
  // 这是 StatefulWidget 必须实现的方法，
  @override
  _PlatformBannerWidgetState createState() => _PlatformBannerWidgetState();
}

// State类，负责管理PlatformBannerWidget的生命周期和UI渲染
class _PlatformBannerWidgetState extends State<PlatformBannerWidget> {
  @override
  Widget build(BuildContext context) {
    print('PlatformBannerWidget placementID: ${widget.placementID}');
    print('PlatformBannerWidget sceneID: ${widget.sceneID}');
    // 判断当前运行平台是否为Android
    if (defaultTargetPlatform == TargetPlatform.android) {
      // 如果是Android平台，使用AndroidView嵌入原生广告视图
      return AndroidView(
        key: UniqueKey(), // 为每个视图分配唯一Key，避免重建时冲突
        viewType: 'my_banner_ad_view', // 与原生注册的viewType保持一致，用于标识广告视图类型
        creationParams: <String, dynamic>{ // 传递给原生的初始化参数
          "placementID": widget.placementID, // 广告位ID
          "sceneID": widget.sceneID,         // 场景ID
        },
        creationParamsCodec: const StandardMessageCodec(), // 参数编解码器，保证Dart与原生数据格式一致
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // 如果是iOS平台，使用UiKitView嵌入原生广告视图
      return UiKitView(
        key: UniqueKey(), // 分配唯一Key
        viewType: "my_banner_ad_view", // 与iOS原生注册的viewType一致
        creationParams: <String, dynamic>{ // 初始化参数
          "placementID": widget.placementID, // 广告位ID
          "sceneID": widget.sceneID,         // 场景ID
        },
        creationParamsCodec: const StandardMessageCodec(), // 参数编解码器
      );
    } else {
      // 如果不是Android或iOS平台，显示不支持提示
      return Text("Unsupported platform");
    }
  }
}