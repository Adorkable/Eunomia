Pod::Spec.new do |s|

  s.name         = "Eunomia"
  s.version      = "3.0.5"
  s.summary      = "OSX and iOS common functionalities"
  s.license      = "MIT"

  s.homepage     = "https://github.com/Adorkable/Eunomia"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/Adorkable/Eunomia.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '2.3' }

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = "Source/Core/**/*.{h,m,swift}"
  end
end
