//
//  MPContactsAuthorization.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

#import "MPContactsAuthorization.h"

@implementation MPContactsAuthorization

+ (CNAuthorizationStatus)authorizationStatusForEntityType:(CNEntityType)entityType
{
    id authorization = NSClassFromString(@"CNAuthorization");
    if ([authorization respondsToSelector:@selector(authorizationStatusForEntityType:)])
    {
        return [authorization authorizationStatusForEntityType:entityType];
    }
    else
    {
        return [CNContactStore authorizationStatusForEntityType:entityType];
    }
}

@end
