//
//  COWImageManager.h
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const COWImageManagerDidConvertImageNotification;

@interface COWImageManager : NSObject

+ (COWImageManager *)sharedImageManager;
- (void)convertImagesFilesAndParameters:(NSArray *)filesAndParameters;

@end
