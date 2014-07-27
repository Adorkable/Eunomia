Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "1.2.0"
  s.summary      = "Our shared library of Utility and Constants (currently only in Objective-C)"

  s.homepage     = "https://bitbucket.org/yoiang/eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://bitbucket.org/yoiang/eunomia", :tag => "1.2.0" }

  s.source_files = "Source/**/*.{h,m}"

  s.public_header_files = "Source/**/*.h"

  s.requires_arc = true

  s.dependency 'CocoaLumberjack'

end
