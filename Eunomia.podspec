Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "1.8"
  s.summary      = "Our shared library of Utility and Constants (currently only in Objective-C)"

  s.homepage     = "https://bitbucket.org/yoiang/eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://bitbucket.org/yoiang/eunomia", :tag => "1.8" }

  s.source_files = "Source/*.{h,m}", "Source/Core/**/*.{h,m}", "Source/Eunomia-Force-Module.swift"

  s.public_header_files = "Source/*.h"
  s.requires_arc = true

  s.dependency 'CocoaLumberjack'
  s.dependency 'SegueingInfo'

end
