//
//  MPPermissionType.h
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw Way Ltd. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSUInteger, MPPermissionType) {
    MPPermissionTypeCalendar = 0,
    MPPermissionTypeReminders,
    MPPermissionTypeContacts,
    MPPermissionTypePhotos,
    MPPermissionTypeFullDiskAccess
} NS_SWIFT_NAME(PermissionType);
