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

### Calendar
10.9+

### Contacts
10.11+

Uses Private API for calling permissions, because public one is not working propertly. See rdar://34158737 

### Reminders
10.9+

### Photos
10.13+

Works only for Photos Extensions. See rdar://34431396 and rdar://43426722

### Full Disk Access
10.14+

There will be no callback when request this type of permission. Calling for permissions opens Preferences->Privacy with selected "Full Disk Access" section. 

## Requirements

*Min OS Version*: 10.9
