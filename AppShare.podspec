Pod::Spec.new do |s|
    s.name         = "AppShare"
    s.version      = "0.0.1"
    s.summary      = "AppShare iOS"
    s.homepage     = "https://github.com/tappytaps/ios-appshare"
    s.license      = 'MIT'
    s.author       = {'TappyTaps s.r.o.' => 'http://tappytaps.com'}
    s.source       = { :git => 'https://github.com/tappytaps/ios-appshare.git',  :tag => "#{s.version}"}
    s.module_name  = 'AppShare'
    s.ios.deployment_target = '9.0'
    s.source_files = 'Sources/**/*.{h,m}'
    s.resource_bundles = {
      'AppShareResources' => ['Sources/AppShare/Resources/*.{xcassets,lproj}']
    }
    s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'FBSDKCOCOAPODS=1' }
    #s.dependency 'FBSDKShareKit'
    #s.dependency 'WechatOpenSDK'
    s.static_framework = true
  end
