Pod::Spec.new do |s|
  s.name             = 'PermissionsKit-macOS'
  s.version          = '1.0.6'
  s.summary          = 'The convenience wrapper on macOS permissions API, including Mojave Full Disk Access.'
  s.description      = <<-DESC
The convenient wrapper on macOS permissions API. You can check and request user permissions to access: Calendar, Reminders, Contacts, Photos and Full Disk Access on Mojave.
                       DESC
  s.module_name       = 'PermissionsKit'					   
  s.homepage          = 'https://github.com/MacPaw/PermissionsKit'
  # s.screenshots     = 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/calendar.png', 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/contacts.png', 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/reminders.png', 'https://raw.githubusercontent.com/MacPaw/PermissionsKit/master/Screenshots/full_disk_access.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Serg Krivoblotsky' => 'krivoblotsky@macpaw.com' }
  s.source           = { :git => 'https://github.com/MacPaw/PermissionsKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Krivoblotsky'

  s.platform = :osx
  s.osx.deployment_target = "10.13"

  s.source_files = 'PermissionsKit/Public/**/*', 'PermissionsKit/Private/**/*', 'PermissionsKit/PermissionsKit.h'

  s.public_header_files = 'PermissionsKit/Public/**/*.h', 'PermissionsKit/PermissionsKit.h'
  s.frameworks = 'Cocoa', 'Contacts', 'EventKit', 'Photos'
end
