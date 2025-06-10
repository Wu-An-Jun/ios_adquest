import 'package:flutter/material.dart';
import 'package:ios_adquest/ios_adquest.dart';
import 'package:ios_adquest/platformview/at_banner_platform_widget.dart';

class BannerAdPage extends StatefulWidget {
  const BannerAdPage({super.key});

  @override
  State<BannerAdPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerAdPage> {
  String _adId = '10007790';
  String _adId2 = '10007800';
  final TextEditingController _controller = TextEditingController(text: '10007790');
  final TextEditingController _controller2 = TextEditingController(text: '10007800');

  Widget _getBannerView(String adId) {
    return PlatformBannerWidget(adId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("横幅广告展示"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 32,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 输入框和第一个广告
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _adId = _controller.text;
                      });
                    },
                    child: Text('切换广告ID'),
                  ),
                  Container(
                    width: 300,
                    height: 150,
                    color: Colors.grey.withOpacity(0.2), // 方便调试
                    child: _getBannerView(_adId),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _controller2,
                      decoration: InputDecoration(
                        labelText: '广告ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _adId2 = _controller2.text;
                      });
                    },
                    child: Text('切换广告ID'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 150,
              color: Colors.grey.withOpacity(0.2), // 方便调试
              child: _getBannerView(_adId2),
            ),
          ],
        ),
      ),
    );
  }
}