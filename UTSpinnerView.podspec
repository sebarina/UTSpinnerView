Pod::Spec.new do |s|
  s.name         = "UTSpinnerView"
  s.version      = "0.0.1"
  s.summary      = "Loading view library and progress circle library"
  s.homepage     = "https://github.com/sebarina/UTSpinnerView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "sebarina xu" => "sebarinaxu@gmail.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/sebarina/UTSpinnerView.git", :tag => "0.0.1" }
  s.source_files  = "Source/**/*"
  s.requires_arc = true

end
