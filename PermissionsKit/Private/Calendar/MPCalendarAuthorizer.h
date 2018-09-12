//
//  MPCalendarAuthorizer.h
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import Foundation;

#import "MPAuthorizer.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCalendarAuthorizer : NSObject <MPAuthorizer>

+ (instancetype)events;
+ (instancetype)reminders;

@end

@interface MPCalendarAuthorizer(Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
