//
//  COWImageConversionOperation.h
//  Cow
//
//  Created by Simon Hau on 20/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COWImageConversionParameters.h"

@interface COWImageConversionOperation : NSOperation
{
    NSArray *imageFiles;
    COWImageConversionParameters *conversionParameters;
}

@property (nonatomic, retain) NSArray *imageFiles;
@property (nonatomic, retain) COWImageConversionParameters *conversionParameters;

- (id)initWithFiles:(NSArray *)files parameters:(COWImageConversionParameters *)aConversionParameters;

@end
