//
//  MPAuthorizer.h
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw Way Ltd. All rights reserved.
//

@import Foundation;

#import "MPAuthorizationStatus.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MPAuthorizer <NSObject>

- (MPAuthorizationStatus)authorizationStatus;
- (void)requestAuthorizationWithCompletion:(void (^)(MPAuthorizationStatus status))completionHandler;

@end

NS_ASSUME_NONNULL_END
