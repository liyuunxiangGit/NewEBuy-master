//
//  GBVoucherDTO.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GBVoucherPreGenerate = 0,       //未生成
    GBVoucherGenerated,             //已生成
    GBVoucherWaitUse,               //已生效
    
}GBVoucherStatus;

@interface GBVoucherDTO : NSObject
{
@private
    NSString    *_voucherCode;          //券号码
    NSString    *_voucherPassword;      //券密码
    NSString    *_sendCount;            //短信发送次数
    NSString    *_startTime;            //起始时间
    NSString    *_endTime;              //结束时间
    NSInteger        _preUsed;               //是否已经生成券
    NSInteger        _notUse;                //是否可以使用
    NSInteger        _overUsed;              //是否已过期
    NSInteger        _used;               //是否已使用
    NSInteger        _obsolete;             //是否已作废
}
@property (nonatomic,copy) NSString   *voucherCode;
@property (nonatomic,copy)NSString    *voucherPassword;
@property (nonatomic,copy)NSString    *sendCount;
@property (nonatomic,copy)NSString    *startTime;
@property (nonatomic,copy)NSString    *endTime;
@property (nonatomic,assign)NSInteger    preUsed;
@property (nonatomic,assign)NSInteger    notUse;
@property (nonatomic,assign)NSInteger    used;
@property (nonatomic,assign)NSInteger    overUsed;
@property (nonatomic,assign)NSInteger    obsolete;
@property (nonatomic)BOOL canRefund;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
