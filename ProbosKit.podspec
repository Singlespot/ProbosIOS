Pod::Spec.new do |s|

  s.name         = "ProbosKit"
  s.version      = "0.2.0"
  s.summary      = "ProbosKit"

  s.description  = <<-DESC
SPTProximityKit
                   DESC

  s.homepage     = "https://www.probos.com"
  s.license = { :type => "Copyright", :text => "      Copyright 2022 Probos, All rights reserved.\n" }
  s.author       = "Probos"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Singlespot/ProbosIOS.git", :tag => 'v' + s.version.to_s }
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

  s.ios.vendored_frameworks = "ProbosKit.xcframework"

  s.framework = 'Foundation'

  s.preserve_paths = "ProbosKit.xcframework"
  s.module_name    = "ProbosKit"
  
  s.requires_arc = true
end

