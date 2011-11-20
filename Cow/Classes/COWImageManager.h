//
//  COWImageManager.h
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COWImageConversionParameters.h"

extern NSString * const COWImageManagerDidConvertImageNotification;

@interface COWImageManager : NSObject
{
    NSOperationQueue *conversionOperationQueue;
}

+ (COWImageManager *)sharedImageManager;
- (void)convertImagesFiles:(NSArray *)imageFiles parameters:(COWImageConversionParameters *)conversionParameters;

@end
