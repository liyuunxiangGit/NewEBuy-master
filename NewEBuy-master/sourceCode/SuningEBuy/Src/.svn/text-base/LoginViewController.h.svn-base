//
//  LoginViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 
 @header   LoginViewController
 @abstract 登录
 @author   刘坤
 @version  4.3  2012/8/16 Creation
 
 */
#import "CommonViewController.h"
#import "UserLoginService.h"
#import "LoginView.h"
#import "LoginHistoryView.h"
#import "CheckNeedVerifyCodeService.h"

@interface LoginViewController : CommonViewController <UserLoginServiceDelegate,UITextFieldDelegate, UIActionSheetDelegate,LoginHistoryViewDelegate, CheckNeedVerifyCodeServiceDelegate>
{
    LoginView   *_loginView;
    BOOL        bNeedVerifyCode;
}

@property (nonatomic, strong) UserLoginService  *service;
@property (nonatomic, strong) CheckNeedVerifyCodeService *checkNeedVerifyCodeService;

@property (nonatomic, strong)  UINavigationController  *nextNavigationController;
@property (nonatomic, strong)  UIViewController        *nextController;
@property (nonatomic,assign) BOOL                      callBackAfterDismissed;

// externAccount,从外部带入账号 （TV扫码支付 使用），XZoscar 2014-05-05 add
@property (nonatomic,strong) NSString                  *externAccount;
@property (nonatomic,assign) BOOL                      isMyEbuy;
@property (nonatomic,assign) BOOL                      isNearBySuning;

@property (nonatomic,assign) BOOL                      isConsultation;
@property (nonatomic, weak) id                loginDelegate;
@property (nonatomic, assign) SEL               loginDidOkSelector;
@property (nonatomic, assign) SEL               loginDidCancelSelector;

@property (nonatomic, strong) LoginHistoryView  *loginHistoryView;

@property (nonatomic, copy) SNBasicBlock loginOkBlock;
@property (nonatomic, copy) SNBasicBlock loginCancelBlock;
@property (nonatomic, strong) UILabel               *vipLable;
@property (nonatomic, strong) UILabel               *vipLable1;

// XZoscar 2014-06-25
// 登录成功后  且 dismissAnimated完成后 会调用
@property (nonatomic,copy) dispatch_block_t       dismissViewControllerComplete;

@property (nonatomic, strong) NSDictionary  *context;   //上下文，用于上下文传递数据

- (void)refreshTable;

// backWayId = 1 ，注册页面直接返回到首页
- (void)showRegisterViewController:(NSInteger)backWayId;

@end
