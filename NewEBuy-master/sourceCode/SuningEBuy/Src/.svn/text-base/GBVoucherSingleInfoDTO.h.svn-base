//
//  GBVoucherSingleInfo.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBConfig.h"

@interface GBVoucherSingleInfoDTO : NSObject
{
    @private
    NSString  *_voucherCode; //券号码
    NSString *_voucherPasswd;//券密码
    NSInteger  _status;//券状态
    NSString *_startTime;//起始时间
    NSString *_endTime;//结束时间
    NSString *_voucherOrderId;//券订单号
    NSString *_spOrderId;//商家订单号
}

@property(nonatomic,copy) NSString *voucherCode;
@property(nonatomic, copy)NSString *voucherPasswd;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *voucherOrderId;
@property (nonatomic,copy)NSString *spOrderId;
@property (nonatomic,strong)NSString *orderItemId;
@property (nonatomic)NSInteger gbType;
@property (nonatomic)NSInteger voucherType;
@property (nonatomic,strong)NSString *spSrc;
@property (nonatomic) BOOL canRefund;

@property (nonatomic)BOOL isSelect;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
