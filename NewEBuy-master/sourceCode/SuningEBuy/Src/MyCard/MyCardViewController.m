//
//  MyCardViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MyCardViewController.h"
#import "AccountListViewController.h"
#import "MobileBoundViewController.h"
#import "EmailBoundViewController.h"

#define DefaultTextColor           [UIColor colorWithRGBHex:0x444444]

@interface MyCardViewController ()
{
    BOOL            isLoadOk;
}

@end

@implementation MyCardViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_memberMergeService);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        isLoadOk = NO;
        self.title = L(@"Electronic membership card");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNotice) name:MERGE_SUCCESS_ACTION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBoundPhoneOK) name:@"LOGINED_BOUND_PHONE" object:nil];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)addBoundPhoneOK
{
    [self presentSheet:L(@"MyEBuy_BindSuccess")];
}

- (void)addNotice
{
    [self presentSheet:L(@"MyEBuy_BindSuccess")];
}

- (void)loadView
{
    [super loadView];
    
    [self addOtherView];
    
    [self.view addSubview:self.cardBack];
    self.hasSuspendButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isLoadOk) {
        [self displayOverFlowActivityView];
        [self.memberMergeService beginSearchMbrCardInfoHttpRequest];
    }
    if ([[UserCenter defaultCenter].userInfoDTO.isBindMobile isEqualToString:@"0"]) {
        self.mobileLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"MobilePhone"),L(@"MyEBuy_NotBindYet")];
    }else{
        self.mobileLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"MobilePhone"),[UserCenter defaultCenter].userInfoDTO.phoneNo];
    }
}

- (void)addOtherView
{
    [self.cardBack addSubview:self.cardLabel];
    [self.cardBack addSubview:self.zbarView];
    [self.view addSubview:self.mobileLabel];
    [self.view addSubview:self.integralLabel];
    [self.view addSubview:self.shopCardLabel];
    [self.view addSubview:self.activeBtn];
    
   // [self.view addSubview:self.tipView];
    [self.view addSubview:self.tipLabel];
}


- (UIImageView *)cardBack
{
    if (!_cardBack) {
        _cardBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vipcard.png"]];
        _cardBack.backgroundColor = [UIColor clearColor];
        
        _cardBack.frame = CGRectMake(34, 20, 252, 132);


        _cardBack.userInteractionEnabled = YES;
//        
//        UIImageView *sep1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine.png"]];
//        sep1.backgroundColor = [UIColor clearColor];
//        sep1.frame = CGRectMake(10, 55, 242, 1);
//        [_cardBack addSubview:sep1];
        
//        UIImageView *sep2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine.png"]];
//        sep2.backgroundColor = [UIColor clearColor];
//        sep2.frame = CGRectMake(10, 160 + 50, 242, 1);
//        [_cardBack addSubview:sep2];
//        
//        UIImageView *sep3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine.png"]];
//        sep3.backgroundColor = [UIColor clearColor];
//        sep3.frame = CGRectMake(10, 210 + 45, 242, 1);
//        [_cardBack addSubview:sep3];
        
    }
    return _cardBack;
}

- (UILabel *)cardLabel
{
    if (!_cardLabel) {
        _cardLabel = [[UILabel alloc] init];
        _cardLabel.backgroundColor = [UIColor clearColor];
        _cardLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"Electronic membership card number"),[UserCenter defaultCenter].userInfoDTO.custNum];
        _cardLabel.frame = CGRectMake(0, 13, 252, 30);
        _cardLabel.textColor = [UIColor whiteColor];
        _cardLabel.font = [UIFont boldSystemFontOfSize:15];
        _cardLabel.textAlignment = UITextAlignmentCenter;
    }
    return _cardLabel;
}

- (EGOImageViewEx *)zbarView
{
    if (!_zbarView) {
        _zbarView = [[EGOImageViewEx alloc] init];
        _zbarView.delegate = self;
        _zbarView.exDelegate = self;
        _zbarView.backgroundColor = [UIColor clearColor];
        _zbarView.frame = CGRectMake((252 - 174) /2, 53, 174, 73);
        NSString *url = [NSString stringWithFormat:@"%@/cust_barcode1D/%@_0_155x65.jpg",kCardPhotoHostAddressHost,[UserCenter defaultCenter].userInfoDTO.custNum];
        _zbarView.imageURL = [NSURL URLWithString:url];
    }
    return _zbarView;
}


- (UILabel *)mobileLabel
{
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc] init];
        _mobileLabel.backgroundColor = [UIColor clearColor];
        _mobileLabel.text = [NSString stringWithFormat:@"%@：",L(@"MobilePhone")];
        if ([[UserCenter defaultCenter].userInfoDTO.isBindMobile isEqualToString:@"0"]) {
            _mobileLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"MobilePhone"),L(@"MyEBuy_NotBind")];
        }else{
            _mobileLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"MobilePhone"),[UserCenter defaultCenter].userInfoDTO.phoneNo];
        }
        _mobileLabel.textColor = [UIColor light_Black_Color];
        _mobileLabel.frame = CGRectMake(20, 165, 260, 30);
        _mobileLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _mobileLabel;
}


- (UILabel *)integralLabel
{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        _integralLabel.backgroundColor = [UIColor clearColor];
        _integralLabel.text = [NSString stringWithFormat:@"%@：",L(@"MyEBuy_Integral")];
        _integralLabel.textColor = [UIColor light_Black_Color];;
        _integralLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"MyEBuy_Integral"),[UserCenter defaultCenter].userInfoDTO.achive];
        _integralLabel.frame = CGRectMake(20, 210, 260, 30);
     
        _integralLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _integralLabel;
}


- (UILabel *)shopCardLabel
{
    if (!_shopCardLabel) {
        _shopCardLabel = [[UILabel alloc] init];
        _shopCardLabel.backgroundColor = [UIColor clearColor];
        _shopCardLabel.text = [NSString stringWithFormat:@"%@：",L(@"Store membership card")];
        _shopCardLabel.textColor = [UIColor light_Black_Color];;
        _shopCardLabel.frame = CGRectMake(20, 255, 260, 30);
        _shopCardLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _shopCardLabel;
}

- (UIButton *)activeBtn
{
    if (!_activeBtn) {
        _activeBtn = [[UIButton alloc] init];
        [_activeBtn setTitle:L(@"Immediately binding") forState:UIControlStateNormal];
        [_activeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _activeBtn.frame = CGRectMake(190, 257, 60, 25);
        [_activeBtn setBackgroundImage:[UIImage streImageNamed:@"orange_button.png"] forState:UIControlStateNormal];
         [_activeBtn setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
        _activeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        [_activeBtn addTarget:self action:@selector(activeAction:) forControlEvents:UIControlEventTouchUpInside];
        _activeBtn.hidden = YES;
    }
    return _activeBtn;
}

- (void)beginSendGetBindMbrCardViewHttp
{
    [self displayOverFlowActivityView];
    [self.memberMergeService beginGetBindMbrCardViewHttpRequest];
}

- (void)activeAction:(id)sender
{
    UserCenter *defaultCenter=[UserCenter defaultCenter];
    
    NSString *logonName = defaultCenter.userInfoDTO.logonId;
    
    NSRange range = [logonName rangeOfString:@"@"];
    
    if (range.location == NSNotFound) {
        if ([defaultCenter.userInfoDTO.isBindMobile isEqualToString:@"0"]) {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips") message:L(@"MyEBuy_NotBind_PleaseBindFirst") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"MyEBuy_GoToBind")];
            [alert setConfirmBlock:^{
                MobileBoundViewController *mobile = [[MobileBoundViewController alloc] init];
                mobile.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mobile animated:YES];
            }];
            [alert show];
            return;
        }
    }else{
        if ([defaultCenter.userInfoDTO.isBindMobile isEqualToString:@"0"] && ([defaultCenter.userInfoDTO.emailStatus isEqualToString:@"0"] || [defaultCenter.userInfoDTO.emailStatus isEqualToString:@"1"]))
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips") message:L(@"MyEBuy_NotBind_PleaseBindFirst") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"MyEBuy_GoToBind")];
            [alert setConfirmBlock:^{
                EmailBoundViewController *email = [[EmailBoundViewController alloc] init];
                email.hidesBottomBarWhenPushed = YES;
                NSRange range = [[UserCenter defaultCenter].userInfoDTO.logonId rangeOfString:@"@"];
                if (range.location != NSNotFound) {
                    email.emailAccount = [UserCenter defaultCenter].userInfoDTO.logonId;
                }
                [self.navigationController pushViewController:email animated:YES];
            }];
            [alert show];
            return;
        }
    }
 
    [self beginSendGetBindMbrCardViewHttp];

}

- (UIImageView *)tipView
{
    if (!_tipView) {
        _tipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_card_tip_image.png"]];
        _tipView.backgroundColor = [UIColor clearColor];
        if (iPhone5) {
            _tipView.frame = CGRectMake(27, self.cardBack.bottom + 36, 17, 17);
        }else{
            _tipView.frame = CGRectMake(27, self.cardBack.bottom + 6, 17, 17);
        }
    }
    return _tipView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textColor = [UIColor dark_Gray_Color];
        _tipLabel.text = [NSString stringWithFormat:@"%@",L(@"MyEBuy_ShowElectronicCardOrReceiveStoreCard")];;
        _tipLabel.frame = CGRectMake(20, 295, 280, 40);
    }
    return _tipLabel;
}


#pragma mark 请求
- (MemeberMergeService *)memberMergeService
{
    if (!_memberMergeService) {
        _memberMergeService = [[MemeberMergeService alloc] init];
        _memberMergeService.delegate = self;
    }
    return _memberMergeService;
}

- (void)searchMbrCardInfoHttpComplete:(MemeberMergeService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        isLoadOk = YES;
        self.shopCardLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"Store membership card"),service.bindMbrCard];
        self.activeBtn.hidden = YES;
    }else{
        isLoadOk = NO;
        self.activeBtn.hidden = NO;
        self.shopCardLabel.text = [NSString stringWithFormat:@"%@： %@",L(@"Store membership card"),L(@"MyEBuy_NotBindYet")];
        if (IsStrEmpty(service.errorMsg)) {
        }else{
            [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg];
        }
    }
}

- (void)getBindMbrCardViewHttpComplete:(MemeberMergeService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (IsArrEmpty(service.cardNoList)) {
            [self presentSheet:@"抱歉，尚未检测出门店会员卡"];
        }else{
            AccountListViewController *list = [[AccountListViewController alloc] init];
            list.accoutList = service.cardNoList;
            [self.navigationController pushViewController:list animated:YES];            
        }
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg];
    }
}


@end
