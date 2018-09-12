//
//  MPPermissionsKit.h
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import Foundation;

#import "MPPermissionType.h"
#import "MPAuthorizationStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPPermissionsKit : NSObject

+ (MPAuthorizationStatus)authorizationStatusForPermissionType:(MPPermissionType)permissionType;
+ (void)requestAuthorizationForPermissionType:(MPPermissionType)permissionType withCompletion:(void (^)(MPAuthorizationStatus status))completionHandler;

@end

NS_ASSUME_NONNULL_END
