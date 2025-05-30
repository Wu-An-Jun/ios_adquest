import 'package:flutter/material.dart';
import 'package:ios_adquest/ios_adquest.dart';
import 'package:ios_adquest/platformview/at_feed_platform_widget.dart';
class NativeAdPage extends StatefulWidget {
  const NativeAdPage({super.key});

  @override
  State<NativeAdPage> createState() => _NativeAdPageState();
}

class _NativeAdPageState extends State<NativeAdPage> {
  String _adId = '10007789';
  final TextEditingController _controller = TextEditingController(text: '10007789');

  Widget _getFeedView(String adId) {
    return PlatformFeedWidget(adId);
  }

  Widget buildNewsCard({Widget? child, String? title, String? desc, String? imageAsset}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageAsset != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imageAsset, height: 120, width: double.infinity, fit: BoxFit.cover),
                  ),
                if (title != null) ...[
                  SizedBox(height: 12),
                  Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF195A94))),
                ],
                if (desc != null) ...[
                  SizedBox(height: 8),
                  Text(desc, style: TextStyle(fontSize: 16, color: Color(0xFF747474))),
                ],
              ],
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("信息流展示")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '广告ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _adId = _controller.text;
                    });
                  },
                  child: Text('切换广告ID'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildNewsCard(
                  title: "Hymn to the United Nations",
                  desc: "Get inspired by this revived W.H. Auden's Hymn to the United Nations...",
                  imageAsset: null,
                ),
                // 广告位卡片
                Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey.withOpacity(0.2), // 方便调试
                  child: _getFeedView(_adId),
                ),
                buildNewsCard(
                  title: "Why do we mark International Days?",
                  desc: "International days and weeks are occasions to educate the public...",
                  imageAsset: 'assets/images/news_image_1.png',
                ),
                Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey.withOpacity(0.2), // 方便调试
                  child: _getFeedView(_adId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}