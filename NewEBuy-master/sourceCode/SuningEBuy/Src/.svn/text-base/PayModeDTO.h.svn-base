//
//  PayModeDTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "payFlowDTO.h"
#import "PayFlowService.h"

@interface PayModeDTO : NSObject

@property (nonatomic, assign) PayMode payMode;  //支付方式
@property (nonatomic, strong) NSString *mainDesc;   //描述
@property (nonatomic, strong) NSString *detailDesc; //详细描述
@property (nonatomic, strong) NSString *detailUnsupportDesc; //不支持支付的描述
@property (nonatomic, assign) BOOL      supportPay;
@property (nonatomic, assign) BOOL      isNew;  //是否是最新的支付方式

//以下两项只有货到付款有
@property (nonatomic, assign) CashOnDeliveryPayMode subPayMode; //货到付款支付方式
@property (nonatomic, strong) NSMutableArray *subPayModeArr;

+ (PayModeDTO *)POSOnDeliveryDTO:(payFlowDTO *)payDTO; //货到付款支付方式刷卡
+ (PayModeDTO *)cashOnDeliveryDTO:(payFlowDTO *)payDTO; //货到付款支付方式现金
+ (PayModeDTO *)efubaoDTO:(payFlowDTO *)payDTO;         //易付宝支付方式
+ (PayModeDTO *)webEfubaoDTO:(payFlowDTO *)payDTO;      //web收银台支付方式
+ (PayModeDTO *)uppay2_0DTO:(payFlowDTO *)payDTO;       //银联2.0
+ (PayModeDTO *)onStoreDTO:(payFlowDTO *)payDTO shipMode:(ShipMode)shipMode;        //门店支付
+ (PayModeDTO *)cyberPayDTO:(payFlowDTO *)payDTO;       //异度支付

+ (PayModeDTO *)POSCard2OnDeliveryDTO:(payFlowDTO *)payDTO; //货到付款支付方式刷卡
+ (PayModeDTO *)cashCard2OnDeliveryDTO:(payFlowDTO *)payDTO; //货到付款支付方式现金
+ (PayModeDTO *)onStoreCard2DTO:(payFlowDTO *)payDTO shipMode:(ShipMode)shipMode;        //门店支付
+ (PayModeDTO *)onLineCard2DTO:(payFlowDTO *)payDTO;        //在线支付

+ (PayModeDTO *)SNPaySDkDTO:(payFlowDTO *)payDTO;           //sdk支付
@end
