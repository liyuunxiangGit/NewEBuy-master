//
//  GroupPurchaseDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-26.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseConstant.h"

@interface GroupPurchaseDTO : NSObject
{    
    PurchaseState  purchaseState_;
    
    //团购活动Id
    NSString    *_grppurId;
    
    NSString    *_partName;
    
    NSString    *_partNumber;
    
    NSString    *_startTime;
    
    //团购押金
    NSString    *_voucherAmount;
    
    NSString    *_productId;
    
    NSString    *_productDesc;
    
    //销售组织
    NSString    *_salesOrg;
    
    //供应商编码
    NSString    *_vendor;
    
    //库位
    NSString    *_depot;
    
    //易购价
    NSString    *_entryPrices;
    
    //当前服务器时间
    NSString    *_currentTime;
    
    //距离团购开始时间的毫秒数
    NSString    *_startTimeMilliSecond;
    
    //距离结束时间的毫秒数
    NSString    *_endTimeMilliSecond;
    
    //团购券活动标志
    NSString    *_virtualGPFlag;
    
    //券显示的价格
    NSString    *_virtualPrice;
    
    //已报名数量
    NSString    *_subscribeAmount;
    
    //优惠金额
    NSString    *_adjustAmount;
    
    //个人限购数量
    NSString    *_perPersonQty;
    
    //最小成团数量
    NSString    *_minQty;
    
    //最大成团数量
    NSString    *_maxQty;
    
    //最小优惠
    NSString    *_minReward;
    
    //最小优惠
    NSString    *_maxReward;
    
    //团购限制总数量
    NSString    *_limitQty;
    
    //团购活动是否已满， 满：true, 否：false
    NSString    *_applyFulledFlag;
    
    //团购结束标识， 1:结束
    NSString    *_gpFinishFlag;
    
    NSURL       *_imageURL;
}
@property (nonatomic, assign) PurchaseState purchaseState;

@property (nonatomic, copy) NSString *grppurId;

@property (nonatomic, copy) NSString *partName;

@property (nonatomic, copy) NSString *partNumber;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *voucherAmount;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *productDesc;

@property (nonatomic, copy) NSString *salesOrg;

@property (nonatomic, copy) NSString *vendor;

@property (nonatomic, copy) NSString *depot;

@property (nonatomic, copy) NSString *entryPrices;

@property (nonatomic, copy) NSString *currentTime;

@property (nonatomic, copy) NSString *startTimeMilliSecond;

@property (nonatomic, copy) NSString *endTimeMilliSecond;

@property (nonatomic, copy) NSString *virtualGPFlag;

@property (nonatomic, copy) NSString *virtualPrice;

@property (nonatomic, copy) NSString *subscribeAmount;

@property (nonatomic, copy) NSString *adjustAmount;

@property (nonatomic, copy) NSString *perPersonQty;

@property (nonatomic, copy) NSString *minQty;

@property (nonatomic, copy) NSString *maxQty;

@property (nonatomic, copy) NSString *minReward;

@property (nonatomic, copy) NSString *maxReward;

@property (nonatomic, copy) NSString *limitQty;

@property (nonatomic, copy) NSString *applyFulledFlag;

@property (nonatomic, copy) NSString *gpFinishFlag;

@property (nonatomic, strong) NSURL *imageURL;


- (void)encodeFromDictionary:(NSDictionary *)dic;

- (void)checkState;

@end
