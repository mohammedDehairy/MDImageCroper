//
//  MDCropperImageView.h
//  MDImageCroper Demo
//
//  Created by mohamed mohamed El Dehairy on 1/12/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDCropperImageViewDelegate;

@interface MDCropperImageView : UIImageView
{
    NSMutableArray *points;
}
@property(nonatomic,weak)id<MDCropperImageViewDelegate> delegate;
@end

@protocol MDCropperImageViewDelegate <NSObject>

-(void)cropEndedWithPath:(CGPathRef)path;

@end
