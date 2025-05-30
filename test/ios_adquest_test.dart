import 'package:flutter_test/flutter_test.dart';
import 'package:ios_adquest/ios_adquest.dart';
import 'package:ios_adquest/ios_adquest_platform_interface.dart';
import 'package:ios_adquest/ios_adquest_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosAdquestPlatform
    with MockPlatformInterfaceMixin
    implements IosAdquestPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IosAdquestPlatform initialPlatform = IosAdquestPlatform.instance;

  test('$MethodChannelIosAdquest is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosAdquest>());
  });

  test('getPlatformVersion', () async {
    IosAdquest iosAdquestPlugin = IosAdquest();
    MockIosAdquestPlatform fakePlatform = MockIosAdquestPlatform();
    IosAdquestPlatform.instance = fakePlatform;

    expect(await iosAdquestPlugin.getPlatformVersion(), '42');
  });
}
