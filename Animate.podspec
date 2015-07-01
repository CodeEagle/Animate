Pod::Spec.new do |s|
  s.name             = "Animate"
  s.version          = "0.1.3"
  s.summary          = "Convenience tool for the Pop animation framework written in Swift"
  s.description      = <<-DESC
                       Convenience tool for the Facebook Pop animation framework written in Swift
                       DESC
  s.homepage         = "https://github.com/CodeEagle/Animate"
  s.screenshots      = "https://raw.githubusercontent.com/CodeEagle/Animate/master/demo2.png", "https://raw.githubusercontent.com/CodeEagle/Animate/master/demo1.png"
  s.license          = 'MIT'
  s.author           = { "CodeEagle" => "stasura@hotmail.com" }
  s.source           = { :git => "https://github.com/CodeEagle/Animate.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/_SelfStudio'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*.swift'
  s.dependency 'pop', '~> 1.0.7'
end
