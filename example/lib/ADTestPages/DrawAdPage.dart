import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:ios_adquest/platformview/at_Draw_platform_widget.dart';

class DrawAdPage extends StatefulWidget {
  const DrawAdPage({Key? key}) : super(key: key);

  @override
  State<DrawAdPage> createState() => _DrawAdPageState();
}

enum DrawItemType { video, ad }

class DrawItem {
  final DrawItemType type;
  final String? videoAsset;
  final String? adId;
  DrawItem.video(this.videoAsset)
      : type = DrawItemType.video,
        adId = null;
  DrawItem.ad(this.adId)
      : type = DrawItemType.ad,
        videoAsset = null;
}

class _DrawAdPageState extends State<DrawAdPage> {
  final List<String> _videoAssets = [
    'assets/videos/video1.mp4',
    'assets/videos/video2.mp4',
    'assets/videos/video3.mp4',
    'assets/videos/video4.mp4',
  ];

  String _adId = '10005127';//10005127
  int _adInterval = 1; // 每1个视频插入1个广告
  late List<DrawItem> items;
  int currentPage = 0;
  final List<VideoPlayerController?> _controllers = [];
  final PageController _pageController = PageController();
  late TextEditingController _adIdController;

  @override
  void initState() {
    super.initState();
    _adIdController = TextEditingController(text: _adId);
    _buildItems();
    _initControllers();
    _initController(currentPage);
  }

  void _buildItems() {
    items = [];
    int videoIndex = 0;
    while (videoIndex < _videoAssets.length) {
      // 插入广告
      if (videoIndex % _adInterval == 0) {
        items.add(DrawItem.ad(_adId));
      }
      // 插入视频
      items.add(DrawItem.video(_videoAssets[videoIndex]));
      videoIndex++;
    }
    // 结尾再插一个广告
    items.add(DrawItem.ad(_adId));
  }

  void _initControllers() {
    _controllers.clear();
    for (var item in items) {
      if (item.type == DrawItemType.video) {
        _controllers.add(VideoPlayerController.asset(item.videoAsset!));
      } else {
        _controllers.add(null);
      }
    }
  }

  Future<void> _initController(int index) async {
    final controller = _controllers[index];
    if (controller != null && !controller.value.isInitialized) {
      await controller.initialize();
      setState(() {});
      controller.play();
    }
  }

  void _onPageChanged(int index) async {
    if (_controllers[currentPage] != null) _controllers[currentPage]!.pause();
    currentPage = index;
    await _initController(index);
    if (_controllers[index] != null) _controllers[index]!.play();

    // 到底自动回到第一页
    if (index == items.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.jumpToPage(0);
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c?.dispose();
    }
    _pageController.dispose();
    _adIdController.dispose();
    super.dispose();
  }

  void _onAdIdChanged(String value) {
    setState(() {
      _adId = value;
      _adIdController.text = value;
      _buildItems();
      _initControllers();
      _initController(0);
      _pageController.jumpToPage(0);
      currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item.type == DrawItemType.video) {
                final controller = _controllers[index];
                if (controller == null || !controller.value.isInitialized) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }
                        });
                      },
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller.value.size.width,
                          height: controller.value.size.height,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ),
                    // 显示广告ID（视频上方，灰色半透明背景）
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '广告位ID: $_adId',
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    if (!controller.value.isPlaying)
                      const Center(
                        child: Icon(Icons.play_circle_outline, color: Colors.white, size: 80),
                      ),
                  ],
                );
              } else {
                // 广告位
                return Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: PlatformDrawWidget(item.adId!),
                    ),
                    // 显示广告ID
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '广告位ID: ${item.adId}',
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          // 顶部栏
          Positioned(
            top: 56,
            left: 0,
            right: 0,
            child: Container(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('推荐', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(width: 16),
                  Text('附近', style: TextStyle(color: Color(0xfff2f2f2), fontWeight: FontWeight.bold, fontSize: 17)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.search, color: Color(0xfff2f2f2)),
                  ),
                ],
              ),
            ),
          ),
          // 底部栏+广告ID输入
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Text('广告位ID:', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '输入广告位ID',
                            hintStyle: const TextStyle(color: Colors.white54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white12,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          ),
                          controller: _adIdController,
                          onSubmitted: _onAdIdChanged,
                          onChanged: (v) {
                            // 只允许数字
                            if (v.isNotEmpty && int.tryParse(v) == null) return;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _onAdIdChanged(_adIdController.text),
                        child: const Text('切换'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: kToolbarHeight,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      _bottomItem('首页', true),
                      _bottomItem('关注', false),
                      Expanded(child: Icon(Icons.add_circle, color: Colors.white, size: 32)),
                      _bottomItem('消息', false),
                      _bottomItem('我', false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomItem(String text, bool selected) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xfff2f2f2),
            fontWeight: FontWeight.bold,
            fontSize: selected ? 18 : 17,
          ),
        ),
      ),
    );
  }
}