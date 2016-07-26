Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "3.0.3"
  s.summary      = "OSX and iOS common functionalities"
  s.license      = "MIT"

  s.homepage     = "https://github.com/Adorkable/Eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/Adorkable/Eunomia.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |core|
    core.dependency 'CocoaLumberjack', '~> 2.2.0'
    core.source_files = "Source/Core/**/*.{h,m,swift}"
  end

#  s.subspec 'Debug' do |debug|
#    debug.prefix_header_contents = "#define DEBUG 1"
##    debug.compiler_flags = '-Wno-incomplete-implementation -Wno-missing-prototypes'
#    debug.dependency 'NSLogger-CocoaLumberjack-connector'
#  end
end
