//
//  MPPhotosAuthorizer.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import Photos;

#import "MPPhotosAuthorizer.h"

@implementation MPPhotosAuthorizer

- (MPAuthorizationStatus)authorizationStatus
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return [self _authorizationStatusFromPhotosAuthorizationStatus:status];
}

- (void)requestAuthorizationWithCompletion:(nonnull void (^)(MPAuthorizationStatus))completionHandler
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        completionHandler([self _authorizationStatusFromPhotosAuthorizationStatus:status]);
    }];
}

#pragma mark - Private

- (MPAuthorizationStatus)_authorizationStatusFromPhotosAuthorizationStatus:(PHAuthorizationStatus)status
{
    switch (status) {
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
            return MPAuthorizationStatusDenied;
        case PHAuthorizationStatusAuthorized:
            return MPAuthorizationStatusAuthorized;
        case PHAuthorizationStatusNotDetermined:
            return MPAuthorizationStatusNotDetermined;
    }
}

@end
