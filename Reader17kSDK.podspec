#
#  Be sure to run `pod spec lint ZNReader.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Reader17kSDK" # 项目名称
  s.version      = "1.2.0"        # 版本号 与 仓库的 标签号 对应
  s.license      = { :type => "MIT", :file => "LICENSE" }          # 开源证书
  s.summary      = "17k听读一体SDK" # 项目简介
  s.homepage     = "https://gitee.com/zm_ios_example/col_sdk_example" # 仓库的主页
  s.source       = { :git => "https://gitee.com/zm_ios_example/col_sdk_example.git", :tag => "#{s.version}" }
  #s.source_files = 'Classes/*','Classes/**/*'
  s.vendored_frameworks = 'Reader17kSDK/*.xcframework'
  s.requires_arc = true # 是否启用ARC
  s.author       = { "Guess" => "zengxsh@col.com" } # 作者信息
  s.platform     = :ios, "9.0" #平台及支持的最低版本
  s.frameworks   = "UIKit", "CoreText" #支持的框架
  s.swift_version = "5.0" #所使用swift版本
end

