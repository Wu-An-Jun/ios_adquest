import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ios_adquest/ios_adquest.dart';
import 'ADTestPages/BannerAdPage.dart';
import 'ADTestPages/InterstitialAdPage.dart';
import 'ADTestPages/NativeAdPage.dart';
import 'ADTestPages/RewardAdPage.dart';
import 'ADTestPages/FullScreenVideoAdPage.dart';
import 'ADTestPages/SplashAdPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = '加载中...';
  final _iosAdquestPlugin = IosAdquest();
  bool _isLoading = true;
  final TextEditingController _urlController =
      TextEditingController(text: 'http://cruiser.bayescom.cn/eleven');
  String? _urlResult;
  String? _urlError;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  // 获取平台版本信息
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await _iosAdquestPlugin.getPlatformVersion() ?? '未知平台版本';
    } on PlatformException {
      platformVersion = '获取平台版本失败';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IOS Adquest 示例'),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
          });
          await initPlatformState();
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const _HeaderSection(),
            const SizedBox(height: 24),
            _InfoCard(
              title: '平台信息',
              content: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      _platformVersion,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: '广告请求URL',
                        border: OutlineInputBorder(),
                        hintText: '请输入广告请求URL',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _urlResult = null;
                            _urlError = null;
                          });
                          try {
                            await _iosAdquestPlugin.setADSdkRequestUrl(_urlController.text);
                            setState(() {
                              _urlResult = '设置成功';
                            });
                          } catch (e) {
                            setState(() {
                              _urlError = e.toString();
                            });
                          }
                        },
                        child: const Text('设置广告请求URL'),
                      ),
                    ),
                    if (_urlResult != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SelectableText.rich(
                          TextSpan(
                            text: _urlResult,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    if (_urlError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SelectableText.rich(
                          TextSpan(
                            text: '错误: ',
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                text: _urlError,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // const _FeaturesList(),
            // const SizedBox(height: 16),
            _AdNavButton(
              title: 'Banner 广告',
              page: const BannerAdPage(),
            ),
            _AdNavButton(
              title: '信息流广告',
              page: const NativeAdPage(),
            ),
            _AdNavButton(
              title: '插屏广告',
              page: const InterstitialAdPage(),
            ),
            _AdNavButton(
              title: '激励广告',
              page: const RewardAdPage(),
            ),
            _AdNavButton(
              title: '全屏视频广告',
              page: const FullScreenVideoAdPage(),
            ),
            _AdNavButton(
              title: '开屏广告',
              page: const SplashAdPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IOS Adquest',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '欢迎使用 IOS Adquest 插件示例应用',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget content;

  const _InfoCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }
}

// class _FeaturesList extends StatelessWidget {
//   const _FeaturesList();
//
//   @override
//   Widget build(BuildContext context) {
//     final features = [
//       {'title': '平台版本检测', 'icon': Icons.info_outline, 'color': Colors.blue},
//       {'title': '广告查询', 'icon': Icons.search, 'color': Colors.green},
//       {'title': '数据统计', 'icon': Icons.bar_chart, 'color': Colors.orange},
//       {'title': '用户跟踪', 'icon': Icons.person_outline, 'color': Colors.purple},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//           child: Text(
//             '功能列表',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//         ),
//         const SizedBox(height: 8),
//         ...features.map((feature) => _FeatureItem(
//               title: feature['title'] as String,
//               icon: feature['icon'] as IconData,
//               color: feature['color'] as Color,
//             )),
//       ],
//     );
//   }
// }

class _FeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _FeatureItem({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title 功能即将推出！')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdNavButton extends StatelessWidget {
  final String title;
  final Widget page;
  const _AdNavButton({required this.title, required this.page, super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => page),
          ),
          child: Text(title),
        ),
      );
}
