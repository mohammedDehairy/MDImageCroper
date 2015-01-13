//
//  MDImageCroper.m
//  MDImageCroper Demo
//
//  Created by mohamed mohamed El Dehairy on 1/12/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import "MDImageCroper.h"

@implementation MDImageCroper
-(CGImageRef)imageMaskWithSize:(CGSize)size withCGPath:(CGPathRef)path
{
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef currentContext = CGBitmapContextCreate(nil, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaOnly);
    
    
    //fill the whole context with black color
    CGContextSetFillColorWithColor( currentContext, [UIColor blackColor].CGColor );
    CGContextFillRect(currentContext, CGRectMake(0, 0, size.width, size.height));
    
    //alow antialiasing
    CGContextSetShouldAntialias(currentContext, YES);
    CGContextSetAllowsAntialiasing(currentContext, YES);
    CGContextSetInterpolationQuality(currentContext, kCGInterpolationHigh);
    
    //draw the path
    CGContextBeginPath (currentContext);
    CGContextAddPath(currentContext, path);
    
    //clip the path so any thing drawn afterwards is clipped at the circle border
    CGContextClip(currentContext);
    
    //clear the rect framing the circle ,so in effect we are clearing only the circle
    CGContextClearRect(currentContext, CGRectMake(0, 0, size.width, size.height));
    
    //render the output CGImageRef
    CGImageRef maskRef = CGBitmapContextCreateImage(currentContext);
    
    //creating an Image mask from the rendered output CGImageRef
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),CGImageGetHeight(maskRef),CGImageGetBitsPerComponent(maskRef),CGImageGetBitsPerPixel(maskRef),CGImageGetBytesPerRow(maskRef),CGImageGetDataProvider(maskRef), NULL, false);
    
    //clean up
    CFRelease(maskRef);
    CFRelease(currentContext);
    CFRelease(colorSpace);
    
    //return the mask
    return mask;
}
-(UIImage*)cropImage:(UIImage *)image withCGPath:(CGPathRef)path
{
    //begin context
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
    
    //get a reference to the current context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //allow antialiasing
    CGContextSetShouldAntialias(currentContext, YES);
    CGContextSetAllowsAntialiasing(currentContext, YES);
    CGContextSetInterpolationQuality(currentContext, kCGInterpolationHigh);
    
    
    //invert the image vertically to compensate for the UIKit/QuartzCore coordiate systems difference
    CGContextTranslateCTM(currentContext, 0.0, image.size.height);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    //Draw the given image to the context
    CGContextDrawImage(currentContext, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    //render the context to a CGImageRef
    CGImageRef cgimage = CGBitmapContextCreateImage(currentContext);
    
    //get the circle mask
    CGImageRef cgmask = [self imageMaskWithSize:image.size withCGPath:path];
    
    //apply the circle mask
    CGImageRef maskedImage = CGImageCreateWithMask(cgimage, cgmask);
    
    //get the output UIImage after applying the circle mask
    UIImage *resultImage = [UIImage imageWithCGImage:maskedImage];
    
    
    //clean up
    if(cgimage)
        CFRelease(cgimage);
    
    if(cgmask)
        CFRelease(cgmask);
    
    if(maskedImage)
        CFRelease(maskedImage);
    
    //end the graphics context
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
