Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "1.6.0"
  s.summary      = "Our shared library of Utility and Constants (currently only in Objective-C)"

  s.homepage     = "https://bitbucket.org/yoiang/eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://bitbucket.org/yoiang/eunomia", :tag => "1.6.0" }

  s.source_files = "Source/**/*.{h,m}"

  s.public_header_files = "Source/**/*.h"

  s.requires_arc = true

  s.dependency 'CocoaLumberjack'

  s.subspec 'Core' do |ss|
  end
  
  s.subspec 'NSLogger' do |ss|
    ss.dependency 'NSLogger'
    ss.dependency 'NSLogger-CocoaLumberjack-connector'
    ss.prefix_header_contents = "#define USE_NSLOGGER 1"
  end
  
  s.subspec "Crashlytics" do |ss|
    ss.dependency 'CrashlyticsFramework'
    ss.dependency 'CrashlyticsLumberjack'
    ss.prefix_header_contents = "#define USE_CRASHLYTICS 1"
  end
  
  s.subspec "TestFlight" do |ss|
    ss.dependency 'TestFlightSDK'
    ss.dependency 'TestFlightLogger'
    ss.prefix_header_contents = "#define USE_TEST_FLIGHT 1"
  end
  
  s.subspec "ARAnalytics_GoogleAnalytics" do |ss|
    ss.dependency 'ARAnalytics/GoogleAnalytics'
    ss.prefix_header_contents = "#define USE_ARANALYTICS 1"
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
  
  s.default_subspecs = 'Core'

end
