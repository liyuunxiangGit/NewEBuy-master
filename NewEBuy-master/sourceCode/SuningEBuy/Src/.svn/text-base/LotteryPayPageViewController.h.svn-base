//
//  LotteryPayPageViewController.h
//  SuningLottery
//
//  Created by yang yulin on 13-5-20.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SubmitLotteryDto.h"
#import "LotteryPayCell.h"
#import "LotteryDealsViewController.h"
#import "LotteryPayRequestService.h"
#import "LoginViewController.h"
#import "AuthManagerNavViewController.h"
#import "UPPayPluginDelegate.h"
#import "EfubaoAccountService.h"

@interface LotteryPayPageViewController : CommonViewController<UITextFieldDelegate,UPPayPluginDelegate,LotteryPayRequestServiceDelegate,EfubaoAccountServiceDelegate>{
    
    BOOL                    isSending;      //是否正在发提交订单请求
    
    
    BOOL                    isEfubaoPay;          //是否是易付宝付款
    
    BOOL                    isRequestFinished;  //是否发送获取余额的请求完成
    
    
}

@property (nonatomic,copy)   NSString          *lotteryInfo;
@property (nonatomic,copy)   NSString          *money;
@property (nonatomic,copy)   NSString          *buyCodes;
@property (nonatomic,copy)   NSString          *payPassword;
@property (nonatomic,copy)   NSString          *projid;
@property (nonatomic,strong) NSMutableArray    *itemList;
@property (nonatomic,strong) SubmitLotteryDto  *lotteryDto;
@property (nonatomic,strong) UILabel           *efubaoLabel;
@property (nonatomic,strong) UILabel           *alertMsgLabel;
@property (nonatomic,strong) UILabel           *efubaoBalanceLabel;
@property (nonatomic,strong) UILabel           *balanceValueLabel;
@property (nonatomic,strong) UILabel           *passwordLabel;
@property (nonatomic,strong) UITextField       *passwordField;
@property (nonatomic,strong) UIButton          *payButton;
@property (nonatomic,strong) UIImageView       *cutLineView;
@property (nonatomic,strong) NSString          *unionUrl;   //传给银联页面的参数

@property(nonatomic,strong) LotteryPayRequestService *lotteryPayRequest;
@property(nonatomic,strong) EfubaoAccountService     *efubaoAccountService;

-(id)initWithSubmitLotteryDTO:(SubmitLotteryDto *)dto;

- (void)changeView;//易付宝未被激活或易付宝余额不足时界面展示

- (void)addView;//获取易付宝余额请求完成时加载界面


@end
