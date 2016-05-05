//
//  flightPayOrderViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-17.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonViewController.h"
#import "payMobileOrderDTO.h"
#import "TPKeyboardAvoidingTableView.h"
#import "SettleItemCell.h"
#import "MyTicketListViewController.h"
#import "FlightOrderService.h"
#import "PlanTicketService.h"
#import "EfubaoAccountService.h"
#import "UPPayPlugin.h"

@interface flightPayOrderViewController : CommonViewController
<UITextFieldDelegate,FlightOrderDelegate,PlanTicketOrderDelegate,EfubaoAccountServiceDelegate,UPPayPluginDelegate>
{
    
    UILabel     *_mobileNumberLabel;
    UILabel     *_mobilequoLabel;
    UILabel     *_payPriceLabel;
    UILabel     *_factPayPriceLabel;
    UILabel     *_yifubaoBalanceLabel;
    UITextField *_payPasswordField;
    
    payMobileOrderDTO *_paySource;
    
    NSArray                *_payMethodArr;
    
    NSString    *_errorTipMsg;
    NSIndexPath *_errorIndexPath;
    
    BOOL        isGetYiFuBao;
}

@property (nonatomic, strong) UILabel    *mobileNumberLabel;
@property (nonatomic, strong) UILabel    *mobilequoLabel;
@property (nonatomic, strong) UILabel    *payPriceLabel;
@property (nonatomic, strong) UILabel    *factPayPriceLabel;
@property (nonatomic, strong) UILabel    *yifubaoBalanceLabel;
@property (nonatomic, strong) UITextField *payPasswordField;
@property (nonatomic, strong) UIButton   *payButton;

@property (nonatomic, strong) payMobileOrderDTO *paySource;  

@property (nonatomic, strong)NSArray                *payMethodArr;

@property (nonatomic, assign)NSInteger              selectedPayModeRow;     // 选中的支付方式
@property (nonatomic, copy)NSString                 *errorTipMsg;            // 错误提示信息
@property (nonatomic, strong)NSIndexPath            *errorIndexPath;         // 错误提示行

@property (nonatomic, strong) NSString *flightOrderId;//订单号
@property (nonatomic, strong) NSString *flightPrice;//订单总金额

@property (nonatomic, strong) FlightOrderService *orderService;
@property (nonatomic, strong) PlanTicketService  *ticketOrderService;
@property (nonatomic, strong) EfubaoAccountService *efubaoService;

- (void)sendFirstEfubaoHttpRequest;

- (void)sendPaymentHttpRequest;

- (void)setupDatasource;

- (id)initRepay;
@end
