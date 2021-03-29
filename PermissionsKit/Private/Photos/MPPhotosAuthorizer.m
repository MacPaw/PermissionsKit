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
    if (@available(macOS 10.13, *))
    {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        return [self _authorizationStatusFromPhotosAuthorizationStatus:status];
    }
    else
    {
        return MPAuthorizationStatusAuthorized;
    }
}

- (void)requestAuthorizationWithCompletion:(nonnull void (^)(MPAuthorizationStatus))completionHandler
{
    if (@available(macOS 10.13, *))
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            completionHandler([self _authorizationStatusFromPhotosAuthorizationStatus:status]);
        }];
    }
    else
    {
        completionHandler(MPAuthorizationStatusAuthorized);
    }
}

#pragma mark - Private

- (MPAuthorizationStatus)_authorizationStatusFromPhotosAuthorizationStatus:(PHAuthorizationStatus)status
API_AVAILABLE(macos(10.13)){
    switch (status) {
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
            return MPAuthorizationStatusDenied;
        case PHAuthorizationStatusAuthorized:
            return MPAuthorizationStatusAuthorized;
        case PHAuthorizationStatusNotDetermined:
            return MPAuthorizationStatusNotDetermined;
		case PHAuthorizationStatusLimited:
			return MPAuthorizationStatusLimited;
	}
    return MPAuthorizationStatusDenied;
}

@end
