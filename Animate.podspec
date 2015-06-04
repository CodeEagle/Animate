#
# Be sure to run `pod lib lint Animate.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Animate"
  s.version          = "0.1.0"
  s.summary          = "Convenience tool for the Pop animation framework written in Swift"
  s.description      = <<-DESC
                       Convenience tool for the Facebook Pop animation framework written in Swift

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/CodeEagle/Animate"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "CodeEagle" => "stasura@hotmail.com" }
  s.source           = { :git => "https://github.com/CodeEagle/Animate.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/_SelfStudio'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*.swift'
  s.dependency 'pop', '~> 1.0.7'
end
