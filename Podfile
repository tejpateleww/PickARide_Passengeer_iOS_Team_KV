# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'PickARide User' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'IQKeyboardManagerSwift', '6.3.0'
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'
  pod 'Cosmos', '~> 23.0'
  pod 'SideMenuSwift'
  pod 'SkyFloatingLabelTextField'
  
  pod 'GoogleSignIn'
  pod 'FBSDKLoginKit'
  
  #Firebase
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Messaging'
  
  # Pods for ApiStructureModulex
  
end
post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
