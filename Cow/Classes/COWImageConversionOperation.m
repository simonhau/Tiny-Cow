//
//  COWImageConversionOperation.m
//  Cow
//
//  Created by Simon Hau on 20/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageConversionOperation.h"
#import "COWImage.h"
#import "COWImageManager.h"

@implementation COWImageConversionOperation

@synthesize imageFiles, conversionParameters;

- (id)initWithFiles:(NSArray *)files parameters:(COWImageConversionParameters *)aConversionParameters
{
    self = [super init];
    if (self) {
        self.imageFiles = files;
        self.conversionParameters = aConversionParameters;
    }
    return self;
}

- (void)dealloc
{
    self.imageFiles = nil;
    self.conversionParameters = nil;
    [super dealloc];
}

- (void)main
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for (NSString *fileName in imageFiles) {
        COWImage *anImage = [[COWImage alloc] initWithContentsOfFile:fileName parameters:conversionParameters];
        if (anImage) {
            // FiXME - save to be customized
            [anImage save];
            [[COWImageManager sharedImageManager] performSelectorOnMainThread:@selector(didConvertImage:) withObject:anImage waitUntilDone:NO];
            [anImage release];
        }
    }
    //[[COWImageManager sharedImageManager] performSelectorOnMainThread:@selector(didConvertImageFiles:) withObject:imageFiles waitUntilDone:NO];
    [pool release];
}

@end
