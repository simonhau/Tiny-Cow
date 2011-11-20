//
//  COWImageManager.m
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageManager.h"
#import "COWImage.h"
#import "COWImageConversionOperation.h"

NSString * const COWImageManagerDidConvertImageNotification =  @"COWImageManagerDidConvertImageNotification";

@implementation COWImageManager

static COWImageManager *sharedImageManager = nil;

#pragma mark - Singleton

- (id)init
{
    self = [super init];
    if (self) {
        conversionOperationQueue = [[NSOperationQueue alloc] init];
        [conversionOperationQueue setMaxConcurrentOperationCount:1];
    }
    return self;
}

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
//    [conversionOperationQueue release];
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

- (void)convertImagesFiles:(NSArray *)imageFiles parameters:(COWImageConversionParameters *)conversionParameters
{
    COWImageConversionOperation *conversionOperation = [[COWImageConversionOperation alloc] initWithFiles:imageFiles parameters:conversionParameters];
    [conversionOperationQueue addOperation:conversionOperation];
    [conversionOperation release];
}

@end
