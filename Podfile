#source 'https://bitbucket.org/yoiang/adorkable-cocoapods.git'
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
# platform :ios, "6.0"

target "Eunomia" do
    pod 'CocoaLumberjack'
    pod 'SegueingInfo'
end

target "EunomiaTests" do
    pod 'Specta'
    pod 'Expecta'
    pod 'OCMock'
end

target "Full Build Test" do
    pod 'Eunomia', :path => './'
    #    pod 'Eunomia/NSLogger', :path => './'
    pod 'Eunomia/Crashlytics', :path => './'
    pod 'Eunomia/ARAnalytics_GoogleAnalytics', :path => './'
    pod 'Eunomia/PonyDebugger', :path => './'
    pod 'Eunomia/Lookback', :path => './'
    pod 'Eunomia/SSDataSources', :path => './'
end

