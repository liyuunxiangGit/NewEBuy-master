//
//  MFVerfyMobileViewCtrler.m
//  SuningEBuy
//
//  Created by suning on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//  xzoscar

#import "MFVerfyMobileViewCtrler.h"

#import "MFFusionViewController.h" // 完善登录密码，执行融合


@interface MFVerfyMobileViewCtrler ()

@end

@implementation MFVerfyMobileViewCtrler

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
    // Do any additional setup after loading the view from its nib.
    [self setTitle:L(@"PageTitleVerifyCellPhone")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)on_nextStepButton_clicked:(UIButton *)sender {
    
    MFFusionViewController *ctrler = [[MFFusionViewController alloc] init];
    [self.navigationController pushViewController:ctrler animated:YES];
}

@end
