//
//  FilterNavigationController.m
//  SuningEBuy
//
//  Created by chupeng on 14-2-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "FilterNavigationController.h"
#import <objc/objc.h>
#import <objc/objc-api.h>
@interface FilterNavigationController ()

@end

@implementation FilterNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = RGBCOLOR(241, 241, 241);
        if (IOS7_OR_LATER)
        {
            
            [self.navigationBar setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(240, 64)] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor colorWithRGBHex:0xdcdcdc] size:CGSizeMake(240, 1)] ;
        }
        else
        {
            UIImage *image = [UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(240, 44)];
            
            if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
            {
                [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            }
            else
            {
                self.navigationBar.layer.contents = (id)image.CGImage;
            }
        }




    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
