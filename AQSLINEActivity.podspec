Pod::Spec.new do |s|
  s.name         = "AQSLINEActivity"
  s.version      = "0.1.0"
  s.summary      = "[iOS] UIActivity Class for LINE"
  s.homepage     = "https://github.com/AquaSupport/AQSLINEActivity"
  s.license      = "MIT"
  s.author       = { "kaiinui" => "lied.der.optik@gmail.com" }
  s.source       = { :git => "https://github.com/AquaSupport/AQSLINEActivity.git", :tag => "v0.1.0" }
  s.source_files  = "AQSLINEActivity/Classes/**/*.{h,m}"
  s.resources = ["AQSLINEActivity/Classes/**/*.png"]
  s.requires_arc = true
  s.platform = "ios", '7.0'

  s.frameworks = "Social"
end
