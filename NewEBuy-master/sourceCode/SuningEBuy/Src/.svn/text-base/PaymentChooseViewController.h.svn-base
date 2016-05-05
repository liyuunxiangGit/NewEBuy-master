//
//  PaymentChooseViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PayFlowService.h"

@protocol PaymentChooseDelegate;
@interface PaymentChooseViewController : CommonViewController<PayFlowServiceDelegate>
{
    
}

@property (nonatomic, assign) id<PaymentChooseDelegate> delegate;
@property (nonatomic, strong) PayFlowService        *payflowService;
@property (nonatomic, strong) payFlowDTO            *payDTO;   //支付参数dto
@property (nonatomic, assign) ShipMode              shipMode;    //配送方式

- (id)initWithPayFlowDTO:(payFlowDTO *)dto andShipMode:(ShipMode)mode;

@end


@protocol PaymentChooseDelegate <NSObject>

- (void)choosePaymentOK:(payFlowDTO *)dto;

@end