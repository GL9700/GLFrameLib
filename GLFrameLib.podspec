#
# Be sure to run `pod lib lint GLFrameLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLFrameLib'
  s.version          = '0.0.1'
  s.summary          = 'A short description of GLFrameLib.'
  s.description      = <<-DESC
  GLFrameLib is FrameLib use scriptFile 
                       DESC

  s.homepage         = 'https://github.com/GL9700/GLFrameLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguoliang' => '36617161@qq.com' }
  s.source           = { :git => 'https://github.com/GL9700/GLFrameLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'GLFrameLib/Classes/**/*'
  s.resource = 'GLFrameLib/Assets/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Yoga'
  s.dependency 'GLExtensions'
  s.dependency 'SDWebImage'
end
