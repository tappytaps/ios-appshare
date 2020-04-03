Pod::Spec.new do |s|
    s.name         = "AppShare"
    s.version      = "0.0.1"
    s.summary      = "Live agent widget for iOS written in swift."
    s.homepage     = "https://github.com/tappytaps/ios-appshare"
    s.license      = 'MIT'
    s.author       = {'TappyTaps s.r.o.' => 'http://tappytaps.com'}
    s.source       = { :git => 'https://github.com/tappytaps/ios-appshare.git',  :tag => "#{s.version}"}
    s.ios.deployment_target = '10.0'
    s.source_files = 'Sources/**/*.{swift}'
    s.resource_bundles = {
      'AppShareResources' => ['Sources/AppShare/Resources/*.{xcassets,lproj}']
    }
    s.dependency 'FBSDKShareKit/Swift'
  end