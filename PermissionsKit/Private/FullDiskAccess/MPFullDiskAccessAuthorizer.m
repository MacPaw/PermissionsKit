//
//  MPFullDiskAccessAuthorizer.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

#import "MPFullDiskAccessAuthorizer.h"

static NSString * const MPFullDiskAccessAuthorizerScriptName = @"preferences";

@interface MPFullDiskAccessAuthorizer()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation MPFullDiskAccessAuthorizer

- (instancetype)initWithFileManager:(NSFileManager *)fileManager
{
    self = [super init];
    if (self)
    {
        _fileManager = fileManager;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFileManager:[NSFileManager defaultManager]];
}

#pragma mark - Public

- (MPAuthorizationStatus)authorizationStatus
{
    return [self _fullDiskAuthorizationStatus];
}

- (void)requestAuthorizationWithCompletion:(nonnull void (^)(MPAuthorizationStatus))completionHandler
{
    [self _openPreferences];
}

#pragma mark - Private

- (MPAuthorizationStatus)_fullDiskAuthorizationStatus
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Safari/Bookmarks.plist"];
    BOOL fileExists = [self.fileManager fileExistsAtPath:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data == nil && fileExists)
    {
        return MPAuthorizationStatusDenied;
    }
    else if (fileExists)
    {
        return MPAuthorizationStatusAuthorized;
    }
    else
    {
        return MPAuthorizationStatusNotDetermined;
    }
}

- (void)_openPreferences
{
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:MPFullDiskAccessAuthorizerScriptName ofType:@"osascript"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self _executeAppleScript:script];
}

- (void)_executeAppleScript:(NSString *)source
{
    @try {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/osascript"];
        NSString *arguments = [NSString stringWithFormat:@"-e %@", source];
        [task setArguments:[NSArray arrayWithObjects:arguments, nil]];
        [task launch];
        [task waitUntilExit];
    } @catch (NSException *e) {
        NSLog(@"Preferences could not be opened, reason: %@", [e reason]);
    }
}

@end
