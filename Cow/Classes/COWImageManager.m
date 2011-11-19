//
//  COWImageManager.m
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageManager.h"
#import "COWImage.h"
#import "COWImageConversionParameters.h"

NSString * const COWImageManagerDidConvertImageNotification =  @"COWImageManagerDidConvertImageNotification";

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

#pragma mark - Image Conversion notifications

- (void)didConvertImage:(COWImage *)image
{
    NSLog(@"didConvertImage:");
    [[NSNotificationCenter defaultCenter] postNotificationName:COWImageManagerDidConvertImageNotification object:image];
}

- (void)didConvertImageFiles:(NSArray *)files
{
    NSLog(@"didConvertImageFiles:");
    // FiXME
}

#pragma mark - Image Conversion

- (void)convertImagesFilesAndParametersInBackground:(NSArray *)filesAndParameters 
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray *files = [filesAndParameters objectAtIndex:0];
    COWImageConversionParameters *conversionParameters = [filesAndParameters objectAtIndex:1];
    NSLog(@"convertImagesFilesAndParametersInBackground - Files: %@", files);        
    for (NSString *fileName in files) {
        COWImage *anImage = [[COWImage alloc] initWithContentsOfFile:fileName];
        if (anImage) {
            COWImage *convertedImage = [anImage convertedImage:conversionParameters];
            [convertedImage save];
            [self performSelectorOnMainThread:@selector(didConvertImage:) withObject:convertedImage waitUntilDone:NO];
            [anImage release];
        }
    }
    [self performSelectorOnMainThread:@selector(didConvertImageFiles:) withObject:files waitUntilDone:NO];
    [pool release];
}

- (void)convertImagesFilesAndParameters:(NSArray *)filesAndParameters
{
    if ([filesAndParameters count] < 2) {
        NSAssert(0, @"convertImagesFilesAndParameters - filesAndParameters empty");
        return;
    }
    [NSThread detachNewThreadSelector:@selector(convertImagesFilesAndParametersInBackground:) toTarget:self withObject:filesAndParameters];
}

@end
