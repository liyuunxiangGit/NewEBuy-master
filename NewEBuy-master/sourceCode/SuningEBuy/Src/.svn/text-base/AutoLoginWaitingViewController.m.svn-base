//
//  AutoLoginWaitingViewController.m
//  SuningEBuy
//
//  Created by chupeng on 14-3-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AutoLoginWaitingViewController.h"

@interface AutoLoginWaitingViewController ()

@end

@implementation AutoLoginWaitingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    
    CGRect rcScreen = [UIScreen mainScreen].bounds;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (rcScreen.size.height - 35) / 2, 320, 35)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.text = L(@"Commands_AutoLogin");
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
