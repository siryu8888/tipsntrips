# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

target 'tipsntrips' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for tipsntrips
  pod ‘Firebase’
  pod ‘Firebase/Auth’
  pod ‘Firebase/Database’

  pod 'Material', '~> 1.0'
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'
  pod 'Kingfisher', '~> 3.0'
  pod 'ChameleonFramework/Swift'
  pod 'UIColor_Hex_Swift', '~> 1.9'
  pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
  pod 'DCPathButton', '~> 2.1.3'
  pod 'Alamofire', '~> 4.0'
  pod 'ReachabilitySwift', :git => 'https://github.com/ashleymills/Reachability.swift'
  pod "CZPicker"
  pod 'IQKeyboardManagerSwift'
  target 'tipsntripsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'tipsntripsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end
