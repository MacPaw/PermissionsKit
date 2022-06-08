# PermissionsKit


[![CI Status](https://img.shields.io/travis/MacPaw/PermissionsKit.svg?style=flat)](https://travis-ci.org/MacPaw/PermissionsKit)
[![Version](https://img.shields.io/cocoapods/v/PermissionsKit-macOS.svg?style=flat)](https://cocoapods.org/pods/PermissionsKit-macOS)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-FC6956.svg?style=flat)](https://github.com/MacPaw/PermissionsKit)
[![Platform](https://img.shields.io/cocoapods/p/PermissionsKit-macOS.svg?style=flat)](https://cocoapods.org/pods/PermissionsKit-macOS)
[![License](https://img.shields.io/cocoapods/l/PermissionsKit-macOS.svg?style=flat)](https://cocoapods.org/pods/PermissionsKit-macOS)

![Calendar](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/logo.png)

The convenient wrapper on macOS permissions API. 

Current implementation supports permissions for: 

* [Calendar](#calendar)
* [Contacts](#contacts)
* [Reminders](#reminders)
* [Photos](#photos)
* [Full Disk Access](#full-disk-access)

## Usage

Available types:
```objc
typedef NS_ENUM(NSUInteger, MPPermissionType) {
    MPPermissionTypeCalendar = 0,
    MPPermissionTypeReminders,
    MPPermissionTypeContacts,
    MPPermissionTypePhotos,
    MPPermissionTypeFullDiskAccess
} NS_SWIFT_NAME(PermissionType);
```

Get permissions status:
```objc
/**
 * Requests current authorization status for a given type.
 *
 * @discussion It is safe to call this method on system where permission type is not supported. MPAuthorizationStatusAuthorized will be returned.
 *
 * @param permissionType MPPermissionType
 * @return MPAuthorizationStatus
 */
+ (MPAuthorizationStatus)authorizationStatusForPermissionType:(MPPermissionType)permissionType;
```

Ask for permissions:
```objc
/**
 * Requests user authorization for a given permission. Completion will be invoked with a user decision. Completion queue is undefined.
 * @discussion There will be no completion when requesting MPPermissionTypeFullDiskAccess, because its status is unknown. You should implement your own callback mechanism, for example - polling authorization. It is safe to call this method on system where permission type is not supported. MPAuthorizationStatusAuthorized will be returned.
 *
 * @param permissionType MPPermissionType
 * @param completionHandler void (^)(MPAuthorizationStatus status)
 */
+ (void)requestAuthorizationForPermissionType:(MPPermissionType)permissionType withCompletion:(void (^)(MPAuthorizationStatus status))completionHandler;
```

## Calendar
10.9+

![Calendar](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/calendar.png)

`NSCalendarsUsageDescription` key in info.plist is required.

## Contacts
10.11+

![Contacts](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/contacts.png)

:warning:Uses **Private API** for calling permissions, because public one is not working properly. See [rdar://34158737](http://www.openradar.me/34158737)

`NSContactsUsageDescription` key is required in Info.plist

## Reminders
10.9+

![Reminders](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/reminders.png)

`NSRemindersUsageDescription` key is required in Info.plist

## Photos
10.13+

:warning:Works only for Photos Extensions. See [rdar://34431396](http://www.openradar.me/34431396) and [rdar://43426722](http://www.openradar.me/43426722)

`NSPhotoLibraryUsageDescription` key is required in Info.plist

## Full Disk Access
10.14+

![FDA](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/full_disk_access.png)

Since there is no legal API to request Full Disk Access permissions on macOS 10.14, this is the only workaround to get and ask for it.

:warning:There will be no callback when requesting this type of permission, so you should use your own implementation such as polling permission status, or use other events to handle possible permission change (for example handle `NSApp` foreground/background status).
Calling for permissions opens Preferences->Privacy with selected "Full Disk Access" section. 

## Application Sandbox:

PermissionsKit can be used in sandboxed applications. It uses multiple files to check for FDA status in case some of the 
tested files are unaccessible due to reasons unrelated to FDA (not present on older systems, UNIX permissions, etc.)
The files are:
* `~/Library/Safari/Bookmarks.plist`
* `~/Library/Safari/CloudTabs.db`
* `/Library/Application Support/com.apple.TCC/TCC.db`
* `/Library/Preferences/com.apple.TimeMachine.plist`
Your app needs to be able to access those files under sandbox. You can do it using Security-Scoped Bookmarks flow(e.g. having a bookmark for root folder), more details in [apple documentation](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/AppSandboxInDepth/AppSandboxInDepth.html#//apple_ref/doc/uid/TP40011183-CH3-SW16)
Or for testing purposes you can add temporary-exception to your .entitlements file.

```
<key>com.apple.security.temporary-exception.files.home-relative-path.read-only</key>
<array>
	<string>Library/Safari/Bookmarks.plist</string>
	<string>Library/Safari/CloudTabs.db</string>
</array>
<key>com.apple.security.temporary-exception.files.absolute-path.read-only</key>
<array>
    <string>/Library/Application Support/com.apple.TCC/TCC.db</string>
    <string>/Library/Preferences/com.apple.TimeMachine.plist</string>
</array>
```

For more details please check [Full Disk Access](#full-disk-access) details.


## Installation

### CocoaPods
PermissionsKit is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:
```ruby
pod 'PermissionsKit-macOS'
```

### Carthage
PermissionsKit is available through [Carthage](https://github.com/Carthage/Carthage). To install it, simple add the following line to your Cartfile:
```ruby
github "MacPaw/PermissionsKit"
```

### Manual
For manual installation just choose the latest available [Release](https://github.com/MacPaw/PermissionsKit/releases) and drag and drop the framework to you project. (You may also need to add it to Embedded Binaries).

## Requirements

macOS 10.9+
However different kinds of permissions require different system version it is safe to call for authorization witout actual system check. `MPAuthorizationStatusAuthorized` will be returned in this case.

## Example 

See PermissionsKitTestApp target

![TestAppScreenshot](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/test_app.png)

## Useful links

* [Full Disk Access](https://forums.developer.apple.com/thread/107546)
* [Contacts](https://developer.apple.com/documentation/contacts/cncontactstore/1402873-requestaccessforentitytype?language=objc)
* [Calendar, Reminders](https://developer.apple.com/documentation/eventkit/ekeventstore/1507239-authorizationstatusforentitytype)
* [Photos](https://developer.apple.com/documentation/photokit/phphotolibrary/1620736-requestauthorization?language=objc)
* [tccutil](https://bitsplitting.org/2018/07/11/reauthorizing-automation-in-mojave/)

## License

MIT License

Copyright (c) 2018 MacPaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
