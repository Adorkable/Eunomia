Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "2.0.0"
  s.summary      = "OSX and iOS common functionalities"

  s.homepage     = "https://bitbucket.org/yoiang/eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://bitbucket.org/yoiang/eunomia", :tag => "2.0.0" }

  s.source_files = "Source/Core/**/*.{h,m}"

  s.public_header_files = "Source/Core/**/*.h"
  s.requires_arc = true

  s.dependency 'CocoaLumberjack'
end
