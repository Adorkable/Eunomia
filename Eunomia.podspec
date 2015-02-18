Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "1.8"
  s.summary      = "Our shared library of Utility and Constants (currently only in Objective-C)"

  s.homepage     = "https://bitbucket.org/yoiang/eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://bitbucket.org/yoiang/eunomia", :tag => "1.8" }

  s.source_files = "Source/*.{h,m,pch}", "Source/Core/**/*.{h,m}", "Source/ThirdParty/*.{h,m}", "Source/ThirdParty/CocoaLumberjack/*.{h,m}"

  s.public_header_files = "Source/*.h", "Source/Core/**/*.h", "Source/ThirdParty/*.h", "Source/ThirdParty/CocoaLumberjack/*.h"

  s.requires_arc = true

  s.dependency 'CocoaLumberjack', '=2.0.0-beta4'
  s.dependency 'SegueingInfo'

  s.subspec 'Core' do |ss|
  end

  s.subspec "CoreMotion" do |ss|
    ss.frameworks = 'CoreMotion'
    ss.prefix_header_contents = "#define USE_COREMOTION 1"
  end

#  s.subspec 'NSLogger' do |ss|
#    ss.dependency 'NSLogger'
#    ss.dependency 'NSLogger-CocoaLumberjack-connector'
#    ss.prefix_header_contents = "#define USE_NSLOGGER 1"
#  end
  
  s.subspec "Crashlytics" do |ss|
    ss.dependency 'CrashlyticsFramework'
    ss.dependency 'CrashlyticsLumberjack', '=2.0.0-beta4'
    ss.prefix_header_contents = "#define USE_CRASHLYTICS 1"
  end
  
  s.subspec "ARAnalytics_GoogleAnalytics" do |ss|
    ss.dependency 'ARAnalytics/GoogleAnalytics'
    ss.prefix_header_contents = "#define USE_ARANALYTICS 1"

    ss.source_files = "Source/ThirdParty/ARAnalytics/*.{h,m}"
    ss.public_header_files = "Source/ThirdParty/ARAnalytics/*.h"
  end
  
  s.subspec "PonyDebugger" do |ss|
    ss.dependency 'PonyDebugger'
#    ss.dependency 'PonyDebuggerLogger'
    ss.prefix_header_contents = "#define USE_PONYDEBUGGER 1"
  end
  
  s.subspec "Lookback" do |ss|
    ss.dependency 'Lookback'
    ss.prefix_header_contents = "#define USE_LOOKBACK 1"
  end

  s.subspec "SSDataSources" do |ss|
    ss.dependency 'SSDataSources'
    ss.prefix_header_contents = "#define USE_SSDATASOURCES 1"

    ss.source_files = "Source/ThirdParty/SSDataSources/*.{h,m}"
    ss.public_header_files = "Source/ThirdParty/SSDataSources/*.h"
  end

  s.default_subspecs = 'Core'

end
