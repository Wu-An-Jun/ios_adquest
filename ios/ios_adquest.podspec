#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ios_adquest.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ios_adquest'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'ios_adquest_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
# 必须集成主SDK
s.dependency 'iOS_AdQuestSDK'
# 集成倍业Adapter
s.dependency 'iOS_AdQuestSDK/MercuryAdapter'
s.dependency 'MercurySDK', '4.4.7'
# 集成穿山甲Adapter
s.dependency 'iOS_AdQuestSDK/CSJAdapter'
s.dependency 'Ads-CN-Beta/BUAdSDK', '6.8.0.1'
s.dependency 'Ads-CN-Beta/CSJMediation', '6.8.0.1'
# 集成广点通Adapter
s.dependency 'iOS_AdQuestSDK/GDTAdapter'
s.dependency 'GDTMobSDK', '4.15.30'
# 集成快手Adapter
s.dependency 'iOS_AdQuestSDK/KSAdapter'
s.dependency 'KSAdSDK', '3.3.74'
# 集成百度Adapter
s.dependency 'iOS_AdQuestSDK/BDAdapter'
s.dependency 'BaiduMobAdSDK', '5.373'
# 集成TanxAdapter
s.dependency 'iOS_AdQuestSDK/TanxAdapter'
s.dependency 'TanxSDK', '3.7.2'
# 集成SigMobAdapter
s.dependency 'iOS_AdQuestSDK/SigmobAdapter'
s.dependency 'SigmobAd-iOS', '4.17.0'
# 第三方
s.dependency 'SDWebImage'
end
