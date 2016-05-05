//
//  InsuranceDTO.h
//  SuningEBuy
//
//  Created by  liukun on 12-11-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CopyCountNone   = 0,    //无
    CopyCountSingle = 1,    //单份
    CopyCountDouble = 2     //双份
}CopyCount;

@interface InsuranceDTO : NSObject <NSCopying>


@property (nonatomic, copy) NSString *prdId; //险种id
@property (nonatomic, copy) NSString *insuranceName; //报名名称
@property (nonatomic, copy) NSString *insuranceDetailInfo; //险种介绍
@property (nonatomic, copy) NSString *salePrice; //售价
@property (nonatomic, copy) NSString *sellNum; //每人限购份数

@property (nonatomic, copy) NSString *supOrderId; //保单号

@property (nonatomic, assign) CopyCount copyCount;  //购买份数

- (void)encodeFromDictionary:(NSDictionary *)items;

@end
