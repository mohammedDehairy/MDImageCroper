//
//  MDImageCroper.h
//  MDImageCroper Demo
//
//  Created by mohamed mohamed El Dehairy on 1/12/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface MDImageCroper : NSObject
-(UIImage*)cropImage:(UIImage *)image withCGPath:(CGPathRef)path;
@end
