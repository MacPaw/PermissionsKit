//
//  MPCalendarAuthorizer.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import EventKit;

#import "MPCalendarAuthorizer.h"

@interface MPCalendarAuthorizer ()

@property (nonatomic) EKEntityType entityType;

@end

@implementation MPCalendarAuthorizer

+ (instancetype)events
{
    return [[self alloc] initWithEntityType:EKEntityTypeEvent];
}

+ (instancetype)reminders
{
    return [[self alloc] initWithEntityType:EKEntityTypeReminder];
}

- (instancetype)initWithEntityType:(EKEntityType)entityType
{
    self = [super init];
    if (self)
    {
        _entityType = entityType;
    }
    return self;
}

#pragma mark - Public

- (MPAuthorizationStatus)authorizationStatus
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:self.entityType];
    return [self _authorizationStatusFromCalendarAuthorizationStatus:status];
}

- (void)requestAuthorizationWithCompletion:(nonnull void (^)(MPAuthorizationStatus))completionHandler
{
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:self.entityType completion:^(BOOL granted, NSError * _Nullable error) {
        completionHandler(granted ? MPAuthorizationStatusAuthorized : MPAuthorizationStatusDenied);
    }];
}

#pragma mark - Private

- (MPAuthorizationStatus)_authorizationStatusFromCalendarAuthorizationStatus:(EKAuthorizationStatus)status
{
    switch (status) {
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
            return MPAuthorizationStatusDenied;
        case EKAuthorizationStatusAuthorized:
            return MPAuthorizationStatusAuthorized;
        case EKAuthorizationStatusNotDetermined:
        case EKAuthorizationStatusWriteOnly:
            return MPAuthorizationStatusNotDetermined;
    }
}

@end
