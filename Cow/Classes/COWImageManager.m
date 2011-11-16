//
//  COWImageManager.m
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageManager.h"
#import "COWImage.h"

NSString * const COWImageManagerDidResizeImageNotification =  @"COWImageManagerDidResizeImageNotification";

@implementation COWImageManager

static COWImageManager *sharedImageManager = nil;

#pragma mark - Singleton

+ (COWImageManager *)sharedImageManager
{
    @synchronized(self) {
        if (sharedImageManager == nil) {
            sharedImageManager = [[COWImageManager alloc] init];
        }
    }
    return sharedImageManager;
}

+ (id)allocWithZone:(NSZone *)zone 
{
    @synchronized(self) {
        if (sharedImageManager == nil) {
            sharedImageManager = [super allocWithZone:zone];
            return sharedImageManager;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone 
{
    return self;
}

- (id)retain 
{
    return self;
}

- (NSUInteger)retainCount 
{
    return NSUIntegerMax;
}

- (oneway void)release 
{
}

- (id)autorelease 
{
    return self;
}

#pragma mark - Image Tools

- (void)didResizeImage:(COWImage *)image
{
    NSLog(@"didResizeImage:");
    [[NSNotificationCenter defaultCenter] postNotificationName:COWImageManagerDidResizeImageNotification object:image];
}

- (void)didResizeImageFiles:(NSArray *)files
{
    NSLog(@"didResizeImageFiles:");
    // FiXME
}

- (void)resizeImagesFilesInBackground:(NSArray *)files
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSLog(@"resizeImagesFilesInBackground - Files: %@",files);        
    for (NSString *fileName in files) {
        COWImage *anImage = [[COWImage alloc] initWithContentsOfFile:fileName];
        if (anImage) {
            COWImage *resizedImage = [anImage resizedImage];
            [resizedImage save];
            [self performSelectorOnMainThread:@selector(didResizeImage:) withObject:resizedImage waitUntilDone:NO];
            [anImage release];
        }
    }
    [self performSelectorOnMainThread:@selector(didResizeImageFiles:) withObject:files waitUntilDone:NO];
    [pool release];
}

- (void)resizeImagesFiles:(NSArray *)files
{
    [NSThread detachNewThreadSelector:@selector(resizeImagesFilesInBackground:) toTarget:self withObject:files];
}

@end
