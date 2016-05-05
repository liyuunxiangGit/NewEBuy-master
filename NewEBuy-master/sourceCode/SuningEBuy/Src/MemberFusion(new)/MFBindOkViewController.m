//
//  MFBindOkViewController.m
//  SuningEBuy
//
//  Created by suning on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//  xzoscar

#import "MFBindOkViewController.h"

@interface MFBindOkViewController ()
@property (nonatomic,strong) IBOutlet UILabel *ebuyAccountLbl;  // 易购账号
@property (nonatomic,strong) IBOutlet UILabel *memberCardNumLbl;// 会员卡号
@property (nonatomic,strong) IBOutlet UILabel *mobileLbl;       // 手机号码
@property (nonatomic,strong) IBOutlet UILabel *scoreTotalLbl;   // 云钻总额
@end

@implementation MFBindOkViewController

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
    [self setTitle:L(@"PageTitleBindSuccess")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)on_touchConfirmButton_clicked:(UIButton *)sender {
    // todo
}

@end
