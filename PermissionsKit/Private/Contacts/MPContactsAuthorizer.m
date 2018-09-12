//
//  MPContactsAuthorizer.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import Contacts;

#import "MPContactsAuthorizer.h"

@implementation MPContactsAuthorizer

- (MPAuthorizationStatus)authorizationStatus
{
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    return [self _authorizationStatusFromContactsAuthorizationStatus:authorizationStatus];
}

- (void)requestAuthorizationWithCompletion:(nonnull void (^)(MPAuthorizationStatus))completionHandler
{
    CNContactStore *store = [CNContactStore new];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        completionHandler(granted ? MPAuthorizationStatusAuthorized : MPAuthorizationStatusDenied);
    }];
}

#pragma mark - Private

- (MPAuthorizationStatus)_authorizationStatusFromContactsAuthorizationStatus:(CNAuthorizationStatus)status
{
    switch (status) {
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusRestricted:
            return MPAuthorizationStatusDenied;
        case CNAuthorizationStatusAuthorized:
            return MPAuthorizationStatusAuthorized;
        case CNAuthorizationStatusNotDetermined:
            return MPAuthorizationStatusNotDetermined;
    }
}

@end
