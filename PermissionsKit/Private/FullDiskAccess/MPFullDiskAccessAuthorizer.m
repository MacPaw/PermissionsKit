//
//  MPFullDiskAccessAuthorizer.m
//  PermissionsKit
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

#import "MPFullDiskAccessAuthorizer.h"
#import <pwd.h>

@interface MPFullDiskAccessAuthorizer()

@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSWorkspace *workspace;
@property (nonatomic, copy) NSString *userHomeFolderPath;

@end

@implementation MPFullDiskAccessAuthorizer

- (instancetype)initWithFileManager:(NSFileManager *)fileManager workspace:(NSWorkspace *)workspace
{
    self = [super init];
    if (self)
    {
        _fileManager = fileManager;
        _workspace = workspace;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFileManager:[NSFileManager defaultManager] workspace:[NSWorkspace sharedWorkspace]];
}

#pragma mark - Public

- (MPAuthorizationStatus)authorizationStatus
{
    if (@available(macOS 10.14, *))
    {
        return [self _fullDiskAuthorizationStatus];
    }
    else
    {
        return MPAuthorizationStatusAuthorized;
    }
}

- (void)requestAuthorizationWithCompletion:(nonnull void (^)(MPAuthorizationStatus))completionHandler
{
    if (@available(macOS 10.14, *))
    {
        [self _openPreferences];
    }
    else
    {
        completionHandler(MPAuthorizationStatusAuthorized);
    }
}

#pragma mark - Private

- (MPAuthorizationStatus)_fullDiskAuthorizationStatus
{
    NSString *path;
    if (@available(macOS 10.15, *))
    {
         path = [self.userHomeFolderPath stringByAppendingPathComponent:@"Library/Safari/CloudTabs.db"];
    }
    else
    {
        path = [self.userHomeFolderPath stringByAppendingPathComponent:@"Library/Safari/Bookmarks.plist"];
    }
    
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

- (NSString *)userHomeFolderPath
{
    @synchronized (self)
    {
        if (!_userHomeFolderPath)
        {
            BOOL isSandboxed = (nil != NSProcessInfo.processInfo.environment[@"APP_SANDBOX_CONTAINER_ID"]);
            if (isSandboxed)
            {
                struct passwd *pw = getpwuid(getuid());
                assert(pw);
                _userHomeFolderPath = [NSString stringWithUTF8String:pw->pw_dir];
            }
            else
            {
                _userHomeFolderPath = NSHomeDirectory();
            }
        }
    }
    return _userHomeFolderPath;
}

- (void)_openPreferences
{
    [self.workspace openURL:[NSURL URLWithString:@"x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"]];
}

@end
