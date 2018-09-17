//
//  MPPhotosAuthorizer.h
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import Foundation;

#import "MPAuthorizer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 MPPhotos authorizer is not working for some reason:
 rdar://34431396
 rdar://43426722
 */
@interface MPPhotosAuthorizer : NSObject <MPAuthorizer>

@end

NS_ASSUME_NONNULL_END
