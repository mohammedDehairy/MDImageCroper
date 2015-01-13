//
//  ViewController.m
//  MDImageCroper Demo
//
//  Created by mohamed mohamed El Dehairy on 1/12/15.
//  Copyright (c) 2015 mohamed mohamed El Dehairy. All rights reserved.
//

#import "ViewController.h"
#import "MDImageCroper.h"

@interface ViewController ()
{
    MDCropperImageView *croperImageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"example_image.png"];
    
    croperImageView = [[MDCropperImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-image.size.width)/2, (self.view.bounds.size.height-image.size.height)/2, image.size.width, image.size.height)];
    croperImageView.userInteractionEnabled = YES;
    croperImageView.contentMode = UIViewContentModeCenter;
    
    croperImageView.image = image;
    croperImageView.delegate = self;
    [self.view addSubview:croperImageView];
}

-(void)cropEndedWithPath:(CGPathRef)path
{
    MDImageCroper *croper = [[MDImageCroper alloc] init];
    
    croperImageView.image = [croper cropImage:croperImageView.image withCGPath:path];
    
    
}
-(IBAction)reset:(id)sender
{
    croperImageView.image = [UIImage imageNamed:@"example_image.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
