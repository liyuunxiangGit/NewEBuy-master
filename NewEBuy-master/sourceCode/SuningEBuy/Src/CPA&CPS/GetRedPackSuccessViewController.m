//
//  GetRedPackSuccessViewController.m
//  SuningEBuy
//
//  Created by leo on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GetRedPackSuccessViewController.h"
#import "MyEbuyViewController.h"
#import "NewInviteFriendViewController.h"
#import "GetRedPackEntryViewController.h"
#import "MyCouponViewController.h"
@interface GetRedPackSuccessViewController ()

@end

@implementation GetRedPackSuccessViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title =L(@"CPACPS_XinrenHongBao");
        [self.view addSubview:self.getsucess];
        [self.view addSubview:self.invitefriend];
        [self.view addSubview:self.entry];
        self.bSupportPanUI = NO;
        [UserCenter defaultCenter].isGetRedPack=NO;
//        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//        NSString *name =@"ciphertime";
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//        [defaults setObject:currentDateStr forKey:name];

        // Custom initialization
    }
    return self;
}

- (void)backForePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_getsucess);
    TT_RELEASE_SAFELY(_invitefriend);
    TT_RELEASE_SAFELY(_entry);
}

-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(UILabel *)getsucess{
    if (!_getsucess) {
        UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hongbao_.png"]];
        imgview.frame = CGRectMake(0, 0, 320,185);
        [self.view addSubview:imgview];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 30, 120, 20)];
        label.text=L(@"CPACPS_CongratulationGet");
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        [self.view addSubview:label];
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(65,40, 170, 60)];
        label3.font = [UIFont boldSystemFontOfSize:30];
        label3.textAlignment = NSTextAlignmentRight;
        label3.textColor = [UIColor whiteColor];
        label3.text = L(@"CPACPS_NewHongbaoQuan");
        label3.backgroundColor = [UIColor clearColor];
        [self.view addSubview:label];
        [self.view addSubview:label3];
        _getsucess = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 300, 20)];
//        _getsucess.text =@"我们已通过优惠券的方式对您发放奖励";
        _getsucess.backgroundColor = [UIColor clearColor];
    }
    return _getsucess;
}

-(UIButton *)invitefriend{
    if (!_invitefriend) {
        _invitefriend = [[UIButton alloc] initWithFrame:CGRectMake(167.5, self.getsucess.bottom+50, 130, 35)];
        [_invitefriend setTitle:L(@"CPACPS_InviteEarnMoney") forState:UIControlStateNormal];
        [_invitefriend.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_invitefriend setTitleColor:[UIColor colorWithRGBHex:0xffffff] forState:UIControlStateNormal];
        [_invitefriend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_invitefriend setBackgroundImage:[UIImage imageNamed:@"submit_button_normal"] forState:UIControlStateNormal];
        [_invitefriend addTarget:self action:@selector(invitefriendclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _invitefriend;
}

-(UIButton *)entry{
    if (!_entry) {
        _entry = [[UIButton alloc] initWithFrame:CGRectMake(22.5, self.getsucess.bottom+50, 130, 35)];
        [_entry setTitle:L(@"CPACPS_CheckYouhuiQuan") forState:UIControlStateNormal];
        [_entry setTitleColor:[UIColor colorWithRGBHex:0xffffff] forState:UIControlStateNormal];
        [_entry.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_entry setBackgroundImage:[UIImage imageNamed:@"button_orange_normal"] forState:UIControlStateNormal];
        [_entry addTarget:self action:@selector(entryclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _entry;
}

-(void)invitefriendclick{
    NewInviteFriendViewController *invite = [[NewInviteFriendViewController alloc] init];
    [self.navigationController pushViewController:invite animated:YES];
    TT_RELEASE_SAFELY(invite);

}

-(void)entryclick{
    MyCouponViewController *egq = [[MyCouponViewController alloc] initWithTotalAmount:[UserCenter defaultCenter].userDiscountInfoDTO.coupon];
    
    [self.navigationController pushViewController:egq animated:YES];
    
    TT_RELEASE_SAFELY(egq);


    
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
