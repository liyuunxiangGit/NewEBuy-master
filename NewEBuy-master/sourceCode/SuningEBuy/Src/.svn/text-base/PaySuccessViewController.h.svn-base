//
//  PaySuccessViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    PayModeByCoupons       = 0,
    PayModeByCash          = 1,
    PayModeByPOS           = 2,
    PayModeByMention       = 3,     //门店支付 自提
    PayModeByStore         = 4,      //门店支付 配送
}PayModeType;

@interface PaySuccessViewController : CommonViewController
{
    
}

@property (nonatomic, assign) PayModeType   paymodeType;
@property (nonatomic, strong) NSString      *orderId;
@property (nonatomic, strong) NSString      *totalPrice;

@property (nonatomic, strong) UILabel       *orderIdLabel;
@property (nonatomic, strong) UILabel       *totalPriceLabel;
@property (nonatomic, strong) UILabel       *payModeTypeLabel;

@end
