//
//  HotelOrderSuccessViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-3.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelOrderSuccessViewController.h"
//#import "SuningEBuyAppDelegate.h"
#import "AppDelegate.h"

@implementation HotelOrderSuccessViewController

@synthesize successImage = _successImage;
@synthesize tipLabel = _tipLabel;
@synthesize goHome = _goHome;
@synthesize goOrderCenter = _goOrderCenter;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_goOrderCenter);
    TT_RELEASE_SAFELY(_goHome);
    TT_RELEASE_SAFELY(_successImage);
    TT_RELEASE_SAFELY(_tipLabel);
    
}


- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"Hotel_Order_Success");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        self.navigationItem.hidesBackButton = YES;
        self.isNeedBackItem = NO;
    }
    return self;
}


- (void)loadView{
    
    [super loadView];
    
    [self.view addSubview:self.successImage];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.goOrderCenter];
    [self.view addSubview:self.goHome];
    
    self.hasSuspendButton=YES;
    
}

- (UIImageView *)successImage{
    
    if (!_successImage) {
        
        _successImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merge_success_face@2x.png"]];
        
        _successImage.frame = CGRectMake(40, 64, 22, 22);
        
        _successImage.backgroundColor = [UIColor clearColor];
    }
    
    return _successImage;
}

- (UILabel *)tipLabel
{

    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 60, 240, 30)];
        
        _tipLabel.text = L(@"Order success,you will get note later");
        
        _tipLabel.textAlignment = UITextAlignmentLeft;
        
        _tipLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        _tipLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _tipLabel;
}


- (UIButton *)goHome{
    
    if (!_goHome) {
        
        _goHome = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [_goHome setBackgroundImage:[UIImage imageNamed:@"button_white_normal@2x.png"] forState:UIControlStateNormal];
        [_goHome setBackgroundImage:[UIImage imageNamed:@"button_white_clicked@2x.png"] forState:UIControlStateSelected];
        
        [_goHome setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        _goHome.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [_goHome setTitle:L(@"goShopping") forState:UIControlStateNormal];
        [_goHome addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
        
        _goHome.frame = CGRectMake(30, 150, 117, 40);
    }
    
    return _goHome;
}


- (void)goToHome{
    
    [self.navigationController popToRootViewControllerAnimated:NO];  
    
    [self jumpToHomeBoard];
}

- (UIButton *)goOrderCenter{
    
    if (!_goOrderCenter) {
        
        _goOrderCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_goOrderCenter setBackgroundImage:[UIImage imageNamed:@"orange_button@2x.png"] forState:UIControlStateNormal];
        [_goOrderCenter setBackgroundImage:[UIImage imageNamed:@"orange_button_clicked@2x.png"] forState:UIControlStateSelected];
        [_goOrderCenter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goOrderCenter.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [_goOrderCenter setTitle:L(@"check the order") forState:UIControlStateNormal];
        [_goOrderCenter addTarget:self action:@selector(goTicketOrderCenter) forControlEvents:UIControlEventTouchUpInside];
        
        _goOrderCenter.frame = CGRectMake(172, 150, 117, 40);
    }
    
    return _goOrderCenter;
}

- (void)goTicketOrderCenter{
    
    [self.navigationController popToRootViewControllerAnimated:NO];

    [self.appDelegate.tabBarViewController setSelectedIndex:4];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldGoToHotelOrderList" object:nil];
    
}

@end
