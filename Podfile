# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'PickARide User' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
    pod 'Alamofire', '5.0'
    pod 'SwiftyJSON', '4.0'
    pod 'IQKeyboardManagerSwift', '6.3.0'
    pod 'Firebase/Messaging'
pod 'GooglePlaces'
    pod 'GooglePlacePicker'
    pod 'GoogleMaps'
  # Pods for ApiStructureModulex

end
post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
end
