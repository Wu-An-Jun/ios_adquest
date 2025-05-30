import 'package:flutter/material.dart';
import 'package:ios_adquest/ios_adquest.dart';

class RewardAdPage extends StatefulWidget {
  const RewardAdPage({super.key});

  @override
  State<RewardAdPage> createState() => _RewardAdPageState();
}

class _RewardAdPageState extends State<RewardAdPage> {
  final TextEditingController _adspotIdController =
      TextEditingController(text: '10007792');
  String? _result;
  String? _error;
  bool _isLoading = false;

  Future<void> _playRewardAd() async {
    setState(() {
      _isLoading = true;
      _result = null;
      _error = null;
    });
    try {
      final res = await IosAdquest().showRewardVideoAd(_adspotIdController.text);
      setState(() {
        _result = res ?? '无返回结果';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Reward Ad')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _adspotIdController,
                decoration: const InputDecoration(
                  labelText: 'adspotId',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _playRewardAd,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('播放激励广告'),
                ),
              ),
              const SizedBox(height: 24),
              if (_result != null)
                SelectableText.rich(
                  TextSpan(
                    text: '广告结果: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: _result,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              if (_error != null)
                SelectableText.rich(
                  TextSpan(
                    text: '错误: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: _error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _adspotIdController.dispose();
    super.dispose();
  }
} 