//
//  VoiceSignViewController.m
//  SuningEBuy
//
//  Created by leo on 14-4-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceSignViewController.h"
#import "RegexKitLite.h"

@interface VoiceSignViewController ()
{
    NSString  *iconurl;
}
@end

@implementation VoiceSignViewController

- (void)dealloc
{
    _chooseShareWayView.delegate = nil;
}

- (id)initWithdto:(VoiceSignDTO *)dto
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.signdto = dto;
        self.title= L(@"PlaySoundSignInHaveGift");//dto.title?dto.title:@"玩转声音,签到有礼";
        NSArray *array=@[@"signsuccess.png",@"allreadysign.png",@"havenosign.png"];
        switch (dto.rewardtype) {
            case HaveSigned:
                iconurl = [array objectAtIndex:1];
                self.exchangelabel.hidden = YES;
                self.pageTitle=L(@"Sound-SignIn-Have");
                break;
            case PhysicalReward:
                iconurl = [array objectAtIndex:0];
                self.pageTitle=L(@"Sound-SignIn-WinPrize");
                break;
            case CloudReward:
                iconurl = [array objectAtIndex:0];
                self.pageTitle=L(@"Sound-SignIn-WinPrize");
                break;
            case NoReward:
                iconurl = [array objectAtIndex:2];
                self.pageTitle=L(@"Sound-SignIn-NotWinPrize");
                break;
            case SignIntegration:
                iconurl = [array objectAtIndex:0];
                self.pageTitle=L(@"Sound-SignIn-WinPrize");
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=L(@"PlaySoundSignInHaveGift");//self.signdto.title?self.signdto.title:@"玩转声音";
    SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"Share")
                                                                Style:SNNavItemStyleDone
                                                               target:self
                                                               action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.view addSubview:self.welcometext];
    self.exchangelabel.frame = CGRectMake(10, 0, 200, 40);
    [self.view addSubview:self.infoview];
    if(self.signdto.rewardtype == PhysicalReward)
    {
//        [self.buttombanner setBackgroundImage:[UIImage imageNamed:self.signdto.imgurl] forState:UIControlStateNormal];
//        [self.buttombanner setImage:[UIImage imageNamed:self.signdto.imgurl] forState:UIControlStateNormal];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *resultData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.signdto.bannerurl]];
            UIImage *img = [UIImage imageWithData:resultData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (img != nil) {
                    [self.view addSubview:self.buttombanner];
                }
            });
        });
        
        
    }
    else
    {
        
    }
    [self.view addSubview:self.markwords];
    // Do any additional setup after loading the view.
}


- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}


//点击分享
- (void)share
{
    [self.shareKit shareWithContent:self.signdto.shareContent  image:nil productImageURL:nil];
    
    [self.chooseShareWayView showChooseShareWayView];
    
}

- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView) {
        _chooseShareWayView = [[ChooseShareWayView alloc] initWithShareTypes:@[SNShareToWeiXin,SNShareToWeiXinFriend,SNShareToSinaWeibo,SNShareToTCWeiBo,SNShareToSMS]];
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//奖品名称
-(UIView *)markwords{
    if (!_markwords) {
         CGSize size =  [self.signdto.prizeTypeName sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(310, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        
        _markwords = [[UIView alloc] initWithFrame:CGRectMake(0, self.infoview.bottom+20, 320, MAX(size.height+16, 20.0f)+10)];
        _markwords.backgroundColor = [UIColor whiteColor];
        _markwords.hidden = NO;

        UITextView *mrakewords = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, MAX(size.height+16, 30.0f))];
        mrakewords.font = [UIFont systemFontOfSize:15];
        mrakewords.scrollEnabled=NO;
        mrakewords.editable=NO;
        
        if(self.signdto.prizeTypeName && self.signdto.rewardtype == PhysicalReward)
        {
            _markwords.hidden = NO;

            if(IsStrEmpty(self.signdto.prizeTypeName))
            {
                mrakewords.text = @"";

            }
            else
            {
                mrakewords.text = [NSString stringWithFormat:@"%@%@",L(@"PrizeName:"),self.signdto.prizeTypeName];

            }

        }
        else if(self.signdto.rewardtype == NoReward || self.signdto.rewardtype == HaveSigned || self.signdto.rewardtype == CloudReward || self.signdto.rewardtype == SignIntegration)
        {
            _markwords.hidden = YES;
        }
        
        mrakewords.backgroundColor = [UIColor clearColor];
        [_markwords addSubview:mrakewords];
    }
    return  _markwords;
}


-(UIView *)infoview{
    if (!_infoview) {
        CGSize size =  [self.signdto.rewardstring sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(310, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];

        _infoview = [[UIView alloc] initWithFrame:CGRectMake(0, self.welcometext.bottom+20, 320, MAX(size.height+16, 20.0f)+15)];
        _infoview.backgroundColor = [UIColor whiteColor];
        UITextView *mrakewords = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, MAX(size.height+16, 20.0f)+5)];
        mrakewords.scrollEnabled=NO;
        mrakewords.font = [UIFont systemFontOfSize:15];
        mrakewords.editable=NO;
        mrakewords.text = self.signdto.rewardstring;
        mrakewords.backgroundColor = [UIColor clearColor];
        [_infoview addSubview:mrakewords];
    }
    return  _infoview;
}

-(UILabel *)welcometext{
    if (!_welcometext) {
        _welcometext = [[UILabel alloc] initWithFrame:CGRectMake(80, 113, 220, 30)];
        _welcometext.backgroundColor = [UIColor clearColor];
        _welcometext.text=L(@"WelcomeSNStore");
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(123, 10, 73, 93)];
        img.image = [UIImage imageNamed:iconurl];
        [self.view addSubview:img];
    }
    return _welcometext;
}

-(UILabel *)exchangelabel{
    if (!_exchangelabel) {
        UIView *exchangeview = [[UIView alloc] init];
        
        if(self.signdto.rewardtype == PhysicalReward)
        {
            exchangeview.frame = CGRectMake(0, self.markwords.bottom+20, 320, 40);
        }
        else
        {
            exchangeview.frame = CGRectMake(0, self.infoview.bottom+20, 320, 40);

        }
        exchangeview.backgroundColor = [UIColor whiteColor];
        exchangeview.hidden = NO;
        _exchangelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        _exchangelabel.backgroundColor = [UIColor clearColor];
        _exchangelabel.font = [UIFont systemFontOfSize:15];
        exchangeview.hidden=YES;
        if (self.signdto.rewardtype == CloudReward) {
            _exchangelabel.text=[NSString stringWithFormat:L(@"CongratulationGet:%@CloudCoupon"),self.signdto.cloudnum];
            exchangeview.hidden=NO;

        }
        else if(self.signdto.rewardtype == PhysicalReward){
            _exchangelabel.text=[NSString stringWithFormat:@"%@%@",L(@"ExchangCode:"),self.signdto.duihuancode];
            exchangeview.hidden=NO;
        }
        else if(self.signdto.rewardtype == SignIntegration){
            _exchangelabel.text=[NSString stringWithFormat:@"%@%@",L(@"GetCloudDiamond:"),self.signdto.cloudnum];
            exchangeview.hidden=NO;
        }
        
        [exchangeview addSubview:_exchangelabel];
        [self.view addSubview:exchangeview];
    }
    return  _exchangelabel;
}

-(EGOImageButton *)buttombanner{
    if (!_buttombanner) {
        _buttombanner = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 320, 50)];
        _buttombanner.backgroundColor = [UIColor clearColor];
        [_buttombanner setImageURL:[NSURL URLWithString:self.signdto.bannerurl]];
        [_buttombanner addTarget:self action:@selector(bannerclick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _buttombanner;
}

-(void)bannerclick{
    
    @weakify(self);
    [SNRouter handleURL:self.signdto.imgurl
             onChecking:^(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self displayOverFlowActivityView];
                 
             } shouldRoute:^BOOL(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self removeOverFlowActivityView];
                 if (obj.errorMsg) {
                     [self showMessage:obj.errorMsg];
                     return NO;
                 }else{
                     return YES;
                 }
                 
                 
             } didRoute:^(SNRouterObject *obj) {
                 
                 
             } source:SNRouteSourceSomeUrl];
}



#pragma mark -
#pragma mark DM回调

-(void)showMessage:(NSString *)string
{
    NSString *errorMsg = string.trim.length?string:L(@"Can not match the Dimensional code!");
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleDefault
                                                         Title:L(@"system-error")
                                                       message:errorMsg
                                                    customView:nil
                                                      delegate:nil
                                             cancelButtonTitle:L(@"Go on reading")
                                             otherButtonTitles:L(@"Return home") ];
    
    [alertView show];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
