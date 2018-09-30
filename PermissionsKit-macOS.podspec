#
# Be sure to run `pod lib lint PermissionsKit-macOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PermissionsKit-macOS'
  s.version          = '0.1.0'
  s.summary          = 'The convenience wrapper on macOS permissions API, including Mojave Full Disk Access.'
  s.description      = <<-DESC
The convenient wrapper on macOS permissions API.
                       DESC
  s.module_name       = 'PermissionsKit'					   
  s.homepage          = 'https://github.com/MacPaw/PermissionsKit'
  # s.screenshots     = 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/calendar.png', 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/contacts.png', 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/reminders.png', 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/full_disk_access.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Serg Krivoblotsky' => 'krivoblotsky@macpaw.com' }
  s.source           = { :git => 'https://github.com/Serg Krivoblotsky/PermissionsKit-macOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Krivoblotsky'

  s.platform = :osx
  s.osx.deployment_target = "10.8"

  s.source_files = 'PermissionsKit/Public/**/*', 'PermissionsKit/Private/**/*', 'PermissionsKit/PermissionsKit.h'
  s.resources = 'PermissionsKit/Resources/scripts/*.osascript'

  s.public_header_files = 'PermissionsKit/Public/**/*.h', 'PermissionsKit/PermissionsKit.h'
  s.frameworks = 'Cocoa', 'Contacts', 'EventKit', 'Photos'
end
