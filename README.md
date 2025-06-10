# ios_adquest

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Android 集成注意事项

### 1. 最低 SDK 版本要求
插件依赖的部分广告 SDK 要求 `minSdkVersion >= 24`，请在你的项目 `android/app/build.gradle(.kts)` 中设置：

```
android {
    defaultConfig {
        minSdkVersion 24 // 或 minSdk = 24
    }
}
```

### 2. NDK 版本要求
插件依赖的部分广告 SDK 要求 `ndkVersion = "27.0.12077973"`，请在 `android/app/build.gradle(.kts)` 中设置：

```
android {
    ndkVersion = "27.0.12077973"
}
```

### 3. Manifest 合并冲突处理
如果遇到 Manifest 合并报错（如 label、allowBackup 冲突），请在 `android/app/src/main/AndroidManifest.xml` 的 `<application>` 标签中添加：

```
<application
    ...
    tools:replace="android:label,android:allowBackup"
    android:allowBackup="true"
    ...>
```
并确保 `<manifest>` 标签包含：
```
<manifest ... xmlns:tools="http://schemas.android.com/tools">
```

### 4. 常见错误与解决方法
- Manifest merger failed: 见上述配置
- minSdkVersion too low: 提升到 24
- NDK version mismatch: 设置为 27.0.12077973

如有疑问请参考 [Flutter 官方文档](https://flutter.dev/to/review-gradle-config) 或提交 issue。

## 广告功能API与用法示例

### 1. 设置广告请求URL
```dart
final adquest = IosAdquest();
await adquest.setADSdkRequestUrl('https://your-ad-url');
```

### 2. 激励视频广告
```dart
final adquest = IosAdquest();
String? result = await adquest.showRewardVideoAd('广告位ID');
```

### 3. 插屏广告
```dart
final adquest = IosAdquest();
String? result = await adquest.showInterstitialAd('广告位ID');
```

### 4. 横幅广告（Banner）
#### 方式一：直接调用API（适合全屏弹窗类）
```dart
final adquest = IosAdquest();
String? result = await adquest.showBannerAd('广告位ID');
```
#### 方式二：作为Widget嵌入页面
```dart
import 'package:ios_adquest/platformview/at_banner_platform_widget.dart';

PlatformBannerWidget('广告位ID')
```

### 5. 信息流广告（Feed）
```dart
import 'package:ios_adquest/platformview/at_feed_platform_widget.dart';

PlatformFeedWidget('广告位ID')
```

### 6. Draw视频信息流广告
```dart
import 'package:ios_adquest/platformview/at_Draw_platform_widget.dart';

PlatformDrawWidget('广告位ID')
```

### 7. 全屏视频广告
```dart
final adquest = IosAdquest();
String? result = await adquest.showFullScreenVideoAd('广告位ID');
```

### 8. 开屏广告
```dart
final adquest = IosAdquest();
String? result = await adquest.showSplashAd('广告位ID');
```

---

> 更多用法请参考 example 目录下的演示页面和源码。

