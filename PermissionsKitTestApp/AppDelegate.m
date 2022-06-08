//
//  AppDelegate.m
//  PermissionsKitTestApp
//
//  Created by Sergii Kryvoblotskyi on 9/12/18.
//  Copyright © 2018 MacPaw. All rights reserved.
//

@import PermissionsKit;

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *contactsLabel;
@property (weak) IBOutlet NSTextField *calendarLabel;
@property (weak) IBOutlet NSTextField *remindersLabel;
@property (weak) IBOutlet NSTextField *photosLabel;
@property (weak) IBOutlet NSTextField *fullDiskAccessLabel;

@property (nonatomic, strong) NSArray <NSTextField *> *statusLabels;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusLabels = @[self.calendarLabel, self.remindersLabel, self.contactsLabel, self.photosLabel, self.fullDiskAccessLabel];
    [self _updateLabels];
}

#pragma mark - Actions

- (IBAction)authorize:(NSButton *)button
{
    [MPPermissionsKit requestAuthorizationForPermissionType:button.tag withCompletion:^(MPAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statusLabels[button.tag].stringValue = [self _stringFromStatus:status];
        });
    }];
}

#pragma mark - Private

- (void)_updateLabels
{
    [self.statusLabels enumerateObjectsUsingBlock:^(NSTextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MPAuthorizationStatus status = [MPPermissionsKit authorizationStatusForPermissionType:idx];
        obj.stringValue = [self _stringFromStatus:status];
    }];
}

- (NSString *)_stringFromStatus:(MPAuthorizationStatus)authorizationStatus
{
    switch (authorizationStatus) {
        case MPAuthorizationStatusDenied: return @"Denied";
        case MPAuthorizationStatusAuthorized: return @"Authorized";
        case MPAuthorizationStatusNotDetermined: return @"Not determined";
        case MPAuthorizationStatusLimited: return @"Limited";
    }
}

@end
