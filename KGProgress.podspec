Pod::Spec.new do |s|
  s.name = "KGProgress"
  s.version = "0.1.4"
  s.summary = "Customizable progress indicator library in Swift"
  s.homepage = "https://github.com/kerry/KGProgress"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "kerry" => "me@prateekgrover.com" }
  s.social_media_url = "http://facebook.com/grover.kerry"
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.source = { :git => "https://github.com/kerry/KGProgress.git", :tag => "#{s.version}" }
  s.source_files = "Sources/**/*.{swift,h,m}"
  s.requires_arc = true
end
