//
//  MPPermissionsKit.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

#import "MPPermissionsKit.h"

@implementation MPPermissionsKit

#pragma mark - Public

+ (MPAuthorizationStatus)authorizationStatusForPermissionType:(MPPermissionType)permissionType
{
    return MPAuthorizationStatusDenied;
}

+ (void)requestAuthorizationForPermissionType:(MPPermissionType)permissionType withCompletion:(void (^)(MPAuthorizationStatus status))completionHandler
{
    
}

#pragma mark - Private

@end
