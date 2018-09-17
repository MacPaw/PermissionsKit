# PermissionsKit

The convenience wrapper on macOS permissions API. 

Current implementation supports permissions for: 

* Calendar
* Contacts
* Reminders
* Photos
* Full Disk Access

## Usage

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

![Contacts](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/calendar.png)

:warning:Uses **Private API** for calling permissions, because public one is not working propertly. See [rdar://34158737](http://www.openradar.me/34158737)

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

:warning:There will be no callback when request this type of permission. Calling for permissions opens Preferences->Privacy with selected "Full Disk Access" section. 

## Requirements

*Min OS Version*: 10.9

## Example 

See PermissionsKitTestApp target

![TestAppScreenshot](https://github.com/MacPaw/PermissionsKit/raw/master/Screenshots/test_app.png)
