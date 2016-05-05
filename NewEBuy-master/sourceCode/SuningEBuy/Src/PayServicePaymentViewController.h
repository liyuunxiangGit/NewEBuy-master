//
//  PayServicePaymentViewController.h
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonViewController.h"
#import "PayServiceDTO.h"
#import "TPKeyboardAvoidingTableView.h"
#import "MobilePayCell.h"
#import "PayServicePaymentService.h"
#import "EfubaoAccountService.h"
#import "UPPayPlugin.h"
#import "SNMPaySDK.h"

@interface PayServicePaymentViewController : CommonViewController <UITextFieldDelegate, PayServicePaymentServiceDelegate,EfubaoAccountServiceDelegate,UPPayPluginDelegate,SNMPaySDKDelegate>
{
    UILabel                          *_customerNameLabel;
    UILabel                          *_payBalanceLabel;
    UILabel                          *_efubaoBalanceLabel;
    
    UITextField                      *_payPasswordTextField;
        
    PayServiceDTO                    *_payDataSource;
    NSArray                          *_payMethodArr;
    
    PayServicePaymentService         *_payServicePaymentService;
}

@property (nonatomic, strong) UILabel        *customerNameLabel;
@property (nonatomic, strong) UILabel        *payBalanceLabel;
@property (nonatomic, strong) UILabel        *efubaoBalanceLabel;
@property (nonatomic, strong) UITextField    *payPasswordTextField;
@property (nonatomic, strong) PayServiceDTO  *payDataSource;
@property (nonatomic, strong) NSArray       *payMethodArr;
@property (nonatomic, assign) NSInteger      selectedPayModeRow;
@property (nonatomic, strong) PayServicePaymentService  *payServicePaymentService;
@property (nonatomic, strong) EfubaoAccountService *eppService;

@property(nonatomic,strong)UILabel *yifubaoBalanceLbl;              //易付宝余额
@property(nonatomic,strong)UILabel *factPriceLbl;                   //实际支付金额
@property (nonatomic, strong) UIImageView *line2;

//@property (nonatomic, strong) UIButton *rightBtn;

- (void)setupDatasource;

@end
