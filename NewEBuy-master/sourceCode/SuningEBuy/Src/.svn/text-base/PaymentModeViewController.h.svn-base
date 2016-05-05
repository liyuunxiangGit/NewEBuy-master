//
//  PaymentModeViewController.h
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PayFlowService.h"
#import "UPPayPluginDelegate.h"
#import "EppValidateCodeService.h"
#import "SNMPaySDK.h"

@interface PaymentModeViewController : CommonViewController
<PayFlowServiceDelegate, UITextFieldDelegate,UPPayPluginDelegate,EppValidateCodeServiceDelegate,SNMPaySDKDelegate>
{
    @private
}


@property (nonatomic, strong) PayFlowService *payFlowService;   //service
@property (nonatomic, strong) EppValidateCodeService *eppValidateService;

@property (nonatomic, strong) payFlowDTO *payDTO;   //支付参数dto
@property (nonatomic, assign) ShipMode shipMode;    //配送方式
@property (nonatomic, assign) BOOL isSecondPay;     //是否是二次支付
/** 是否展示总价格 默认YES*/
@property (nonatomic, assign) BOOL isShowTotalPrice;

- (id)initWithPayFlowDTO:(payFlowDTO *)dto andShipMode:(ShipMode)mode;
- (id)initWithPayFlowDTO:(payFlowDTO *)dto andShipMode:(ShipMode)mode allPaytype:(BOOL)payType;
- (void)getVerifyCode:(id)sender;

@end
