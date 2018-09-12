//
//  MPContactsAuthorization.h
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import Foundation;
@import Contacts;

NS_ASSUME_NONNULL_BEGIN

@interface MPContactsAuthorization : NSObject

+ (CNAuthorizationStatus)authorizationStatusForEntityType:(CNEntityType)entityType;

@end

NS_ASSUME_NONNULL_END
