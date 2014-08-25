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
    pod 'Eunomia', :path => './Eunomia.podspec'
    pod 'Eunomia/NSLogger', :path => './Eunomia.podspec'
    pod 'Eunomia/Crashlytics', :path => './Eunomia.podspec'
    pod 'Eunomia/TestFlight', :path => './Eunomia.podspec'
    pod 'Eunomia/ARAnalytics_GoogleAnalytics', :path => './Eunomia.podspec'
    pod 'Eunomia/PonyDebugger', :path => './Eunomia.podspec'
    pod 'Eunomia/Lookback', :path => './Eunomia.podspec'
end

