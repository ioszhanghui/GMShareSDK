#
# Be sure to run `pod lib lint GMShareSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GMShareSDK'
  s.version          = '0.1.0'
  s.summary          = '国美分享'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
只包含微信分享的 分享工具
                       DESC

  s.homepage         = 'https://github.com/ioszhanghui/GMShareSDK.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ioszhanghui@163.com' => 'yomingyo@gmail.com' }
  s.source           = { :git => 'https://github.com/ioszhanghui/GMShareSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  
  s.source_files = 'GMShareSDK/Classes/**/*'


  s.dependency 'GMThirdLibrary/GMUMSDK'
  s.dependency 'GMmacros'
  s.dependency 'Masonry'

  
  s.resources = ['GMShareSDK/Assets/all/*.png']
  
  s.prefix_header_contents = '#import<GMmacros/macros.h>','#import <Masonry/Masonry.h>',' #import <YYCategories/YYCategories.h>','#import <MJExtension/MJExtension.h>','#import <MJExtension/MJExtension.h>'

  
  # s.resource_bundles = {
  #   'GMShareSDK' => ['GMShareSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
