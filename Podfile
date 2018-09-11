source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.4'

use_frameworks!
inhibit_all_warnings!

pod 'Malibu', '~> 7.0'
pod 'R.swift', '~> 4.0', configurations: 'Debug'
pod 'SwiftLint', '0.27.0', configurations: 'Debug'

target 'Food2Fork'

target 'Food2ForkTests' do
  pod 'Malibu', '~> 7.0'
  inherit! :search_paths
end

target 'Food2ForkUITests' do
  pod 'R.swift', '~> 4.0'
end
