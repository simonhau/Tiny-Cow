//
//  COWAppDelegate.m
//  Cow
//
//  Created by Simon Hau on 12/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWAppDelegate.h"
#import "COWStatusItemView.h"

@interface COWAppDelegate () 
- (void)setupStatusItemAndMenu;
- (void)setupPreferencesWindow;
- (void)showPreferencesWindow;
@end

@implementation COWAppDelegate

@synthesize window;
@synthesize cleanHistoryPreferencesButton;
@synthesize savePreferencesMatrix;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}

- (void)awakeFromNib
{
    [self setupStatusItemAndMenu];
    [self setupPreferencesWindow];
}

#pragma mark - Interface Initialization

- (void)setupStatusItemAndMenu
{
    NSStatusItem *statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:kCOWStatusItemWidth] retain];

    COWStatusMenu *statusMenu = [[COWStatusMenu alloc] init];
    [statusItem setMenu:statusMenu];
    [statusMenu release];

    COWStatusItemView *statusItemView = [[COWStatusItemView alloc] init];
    [statusMenu setDelegate:statusItemView];
    [statusItemView setStatusItem:statusItem];
    [statusItem setView:statusItemView];
    [statusItemView release];
}
    

- (void)setupPreferencesWindow
{
    NSAssert([[savePreferencesMatrix cells] count] == 3, @"saveMatrix 3");
    
    NSButtonCell *temporarySaveButtonCell = [[savePreferencesMatrix cells] objectAtIndex:0];
    [temporarySaveButtonCell setTitle:NSLocalizedString(@"preferences.saveFiles.temporaryDirectory", nil)];
    
    NSButtonCell *sameDirectorySaveButtonCell = [[savePreferencesMatrix cells] objectAtIndex:1];
    [sameDirectorySaveButtonCell setTitle:NSLocalizedString(@"preferences.saveFiles.sameDirectory", nil)];
    
    NSButtonCell *customSaveButtonCell = [[savePreferencesMatrix cells] objectAtIndex:2];
    [customSaveButtonCell setTitle:NSLocalizedString(@"preferences.saveFiles.customDirectory", nil)];
    
    [savePreferencesMatrix setEnabled:NO];
    [cleanHistoryPreferencesButton setEnabled:NO];
}

#pragma mark - Preferences

- (void)showPreferencesWindow
{
    [window orderFrontRegardless];
}

- (IBAction)cleanHistory:(NSButton *)sender 
{
    NSLog(@"cleanHistory");
}

- (IBAction)fileSaveRadioClicked:(NSMatrix *)sender 
{
    NSButtonCell *selectedButton = [sender selectedCell];
    if ([[selectedButton title] isEqualToString:NSLocalizedString(@"preferences.saveFiles.temporaryDirectory", nil)]) {
        NSLog(@"temporaryDirectory");
    }
    else if ([[selectedButton title] isEqualToString:NSLocalizedString(@"preferences.saveFiles.sameDirectory", nil)]) {
        NSLog(@"sameDirectory");    
    }
    else if ([[selectedButton title] isEqualToString:NSLocalizedString(@"preferences.saveFiles.customDirectory", nil)]) {
        NSLog(@"customDirectory");            
    }
    else {
        NSAssert(0, @"fileSaveRadioClicked Error");
    }
}

- (IBAction)toggleStartOnSystemStartup:(NSButton *)sender 
{
    if ([sender state]) {
        NSLog(@"toggleStartOnSystemStartup - ON");    
    }
    else {
        NSLog(@"toggleStartOnSystemStartup - OFF");            
    }
}

@end
