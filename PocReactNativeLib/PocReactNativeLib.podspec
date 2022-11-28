#
# Be sure to run `pod lib lint PocReactNativeLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

require 'json'

# Returns the version number for a package.json file
pkg_version = lambda do |dir_from_root = '', version = 'version'|
  path = File.join(__dir__, dir_from_root, 'package.json')
  JSON.parse(File.read(path))[version]
end

# Let the main package.json decide the version number for the pod
poc_lib_version = pkg_version.call
# Use the same RN version that the JS tools use
react_native_version = pkg_version.call('node_modules/react-native')

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'



Pod::Spec.new do |s|
  s.name             = 'PocReactNativeLib'
  s.version          = poc_lib_version
  s.summary          = 'A short description of PocReactNativeLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Seras3/PocReactNativeLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Seras3' => 'adrian_etto@yahoo.com' }
  s.source           = { :git => 'https://github.com/Seras3/PocReactNativeLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13'

  s.source_files   = 'Pod/Classes/**/*.{h,m}'
  s.resources      = 'Pod/Assets/{ios.bundle.js,assets}'

  s.compiler_flags  = folly_compiler_flags

  s.pod_target_xcconfig    = {
    "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\""
  }

  # New Architecture : https://reactnative.dev/docs/new-architecture-library-ios

  # React is split into a set of subspecs, these are the essentials
  s.dependency 'React', react_native_version
  s.dependency 'React-Core', react_native_version
  # s.dependency 'React-RCTFabric', react_native_version  # This is for Fabric Native Component
  s.dependency 'React-Codegen', react_native_version
  s.dependency 'RCTRequired', react_native_version
  s.dependency 'RCTTypeSafety', react_native_version
  s.dependency 'ReactCommon/turbomodule/core'

  s.dependency 'React-RCTActionSheet', react_native_version
  s.dependency 'React-RCTAnimation', react_native_version
  s.dependency 'React-RCTBlob', react_native_version
  s.dependency 'React-RCTImage', react_native_version
  s.dependency 'React-RCTLinking', react_native_version
  s.dependency 'React-RCTNetwork', react_native_version
  s.dependency 'React-RCTSettings', react_native_version
  s.dependency 'React-RCTText', react_native_version
  s.dependency 'React-RCTVibration', react_native_version



  podspecs = [
    'node_modules/react-native/ReactCommon/yoga/Yoga.podspec',
    'node_modules/react-native/third-party-podspecs/DoubleConversion.podspec',
    'node_modules/react-native/third-party-podspecs/RCT-Folly.podspec',
    'node_modules/react-native/third-party-podspecs/glog.podspec',
    'node_modules/react-native/third-party-podspecs/boost.podspec'
  ]
  podspecs.each do |podspec_path|
    spec = Pod::Specification.from_file podspec_path
    s.dependency spec.name, "#{spec.version}"
  end
  
  # s.resource_bundles = {
  #   'PocReactNativeLib' => ['PocReactNativeLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end



