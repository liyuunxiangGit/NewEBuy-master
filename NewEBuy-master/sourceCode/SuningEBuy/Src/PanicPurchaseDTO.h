//
//  PanicPurchaseDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseConstant.h"
#import "DataProductBasic.h"

@interface PanicPurchaseDTO : NSObject
{
    //抢购活动ID
    NSString     *_rushPurId;
    
    //抢购开始时间
    NSString     * _startTime;
    
    //抢购结束时间
    NSString     * _endTime;
    
    //当前服务器时间
    NSString *_currentTime;
    
    //总限购数量
    NSString *_totalQtyLmt;
    
    //剩余数量
    NSString   *_leftQty;
    
    //商品ID
    NSString  *_catentryId;
    
    //商品编码
    NSString  *_partNumber;
    
    //商品名称
    NSString *_catentryName;
    
    //目录ID
    NSString  *_catalogId;
    
    //活动状态
    PurchaseState purchaseState_;
    
    //易购价
    NSString  *_netPrice;
    
    //抢购价
    NSString  *_rushPurPrice;
    
    NSURL *_imageURL;
    
    //商品描述
    NSString *_descriptions;
    
    NSString  *_isSale;//城市是否销售

}

@property (nonatomic,copy) NSString *rushPurId;

@property (nonatomic,copy)NSString *startTime;

@property (nonatomic,copy)NSString  *endTime;

@property (nonatomic,copy)NSString *currentTime;

@property (nonatomic,copy)NSString *totalQtyLmt;

@property (nonatomic,copy)NSString *leftQty;

@property(nonatomic,copy)NSString *catentryId;

@property(nonatomic,copy)NSString *partNumber;

@property(nonatomic,copy)NSString *catentryName;

@property(nonatomic,copy)NSString *catalogId;

@property(nonatomic,assign)PurchaseState purchaseState;

@property(nonatomic,copy)NSString *netPrice;

@property(nonatomic,copy)NSString *rushPurPrice;

@property(nonatomic,copy)NSURL   *imageURL;

@property(nonatomic,copy)NSString *descriptions;

@property (nonatomic,copy) NSString *isSale;

@property (nonatomic,copy) NSString *shopCode;      //供应商编码，默认@“”即苏宁自营

@property (nonatomic,copy) NSString *startFlag;     //0:未开始 ；1：正在销售 ；2：已结束

@property (nonatomic, assign) NSTimeInterval startTimeSeconds;
@property (nonatomic, assign) NSTimeInterval endTimeSeconds;

- (void)checkState;

//抢购列表B2C渠道
- (void)encodeRushListForB2CFromDic:(NSDictionary *)dic;
//抢购详情B2C渠道
- (void)encodeRushDetailForB2CFromDic:(NSDictionary *)dic;
//Mobile渠道的抢购解析
- (void)encodeRushForMobileFromDic:(NSDictionary *)dic;


- (DataProductBasic *)transformToProductDTO;

@end
