//
//  MFFusionViewController.m
//  SuningEBuy
//
//  Created by suning on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//  xzoscar

#import "MFFusionViewController.h"
#import "MFBindOkViewController.h" // 绑定成功 信息展示


@interface MFFusionViewController ()

@end

@implementation MFFusionViewController

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
     [self setTitle:L(@"PageTitlePerfectLoginPassword")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)on_finishButton_clicked:(UIButton *)sender {
    
    MFBindOkViewController *ctrler = [[MFBindOkViewController alloc] init];
    [self.navigationController pushViewController:ctrler animated:YES];
}

@end
