//
//  MPPermissionsKit.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

#import "MPPermissionsKit.h"

#import "MPAuthorizer.h"
#import "MPPhotosAuthorizer.h"
#import "MPFullDiskAccessAuthorizer.h"
#import "MPCalendarAuthorizer.h"
#import "MPContactsAuthorizer.h"

typedef NSDictionary<NSNumber *, id<MPAuthorizer>> * MPAuthorizersMap;

@implementation MPPermissionsKit

#pragma mark - Public

+ (MPAuthorizationStatus)authorizationStatusForPermissionType:(MPPermissionType)permissionType
{
    id <MPAuthorizer> authorizer = self.authorizers[@(permissionType)];
    NSAssert(authorizer != nil, @"Could not find authorizer for type %ld", permissionType);
    return authorizer.authorizationStatus;
}

+ (void)requestAuthorizationForPermissionType:(MPPermissionType)permissionType withCompletion:(void (^)(MPAuthorizationStatus status))completionHandler
{
    id <MPAuthorizer> authorizer = self.authorizers[@(permissionType)];
    NSAssert(authorizer != nil, @"Could not find authorizer for type %ld", permissionType);
    [authorizer requestAuthorizationWithCompletion:completionHandler];
}

#pragma mark - Private

+ (MPAuthorizersMap)authorizers
{
    static MPAuthorizersMap map;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
                @(MPPermissionTypePhotos) : [MPPhotosAuthorizer new],
                @(MPPermissionTypeContacts) : [MPContactsAuthorizer new],
                @(MPPermissionTypeCalendar) : [MPCalendarAuthorizer events],
                @(MPPermissionTypeReminders) : [MPCalendarAuthorizer reminders],
                @(MPPermissionTypeFullDiskAccess) : [MPFullDiskAccessAuthorizer new]
                };
    });
    return map;
}

@end
