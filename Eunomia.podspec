Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "3.8.2"
  s.summary      = "OSX and iOS common functionalities"
  s.license      = "MIT"

  s.homepage     = "https://github.com/Adorkable/Eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.13'

  s.source       = { :git => "https://github.com/Adorkable/Eunomia.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }
  s.swift_version = '5.0'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = "Source/Core/**/*.{h,m,swift}"
  end
end
