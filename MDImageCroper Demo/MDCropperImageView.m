//
//  MDCropperImageView.m
//  MDImageCroper Demo
//
//  Created by mohamed mohamed El Dehairy on 1/12/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import "MDCropperImageView.h"

@implementation MDCropperImageView


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    points = [NSMutableArray array];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPosition = [touch locationInView:self];
    
    [points addObject:[NSValue valueWithCGPoint:touchPosition]];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPosition = [touch locationInView:self];
    
    [points addObject:[NSValue valueWithCGPoint:touchPosition]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    if (points && points.count > 0) {
        CGPoint p = [(NSValue *)[points objectAtIndex:0] CGPointValue];
        
        p = CGPointMake(p.x, self.image.size.height - p.y);
        
        CGPathMoveToPoint(path, nil, p.x, p.y);
        for (int i = 1; i < points.count; i++) {
            p = [(NSValue *)[points objectAtIndex:i] CGPointValue];
            p = CGPointMake(p.x, self.image.size.height - p.y);
            CGPathAddLineToPoint(path, nil, p.x, p.y);
        }
    }
    
    if([_delegate respondsToSelector:@selector(cropEndedWithPath:)])
    {
        [_delegate cropEndedWithPath:path];
    }
    
    points = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
