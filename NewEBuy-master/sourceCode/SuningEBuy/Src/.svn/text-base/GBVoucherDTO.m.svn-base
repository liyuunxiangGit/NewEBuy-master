//
//  GBVoucherDTO.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GBVoucherDTO.h"

@implementation GBVoucherDTO
@synthesize voucherCode = _voucherCode;
@synthesize voucherPassword = _voucherPassword;
@synthesize sendCount = _sendCount;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize preUsed  = _preUsed;
@synthesize notUse = _notUse;
@synthesize overUsed = _overUsed;
@synthesize used = _used;
@synthesize obsolete = _obsolete;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return ;
    }
    
    self.voucherCode  = EncodeStringFromDic(dic, @"voucherCode");
    self.voucherPassword = EncodeStringFromDic(dic, @"voucherPasswd");
    self.sendCount = EncodeStringFromDic(dic, @"sendCount");
    if (EncodeStringFromDic(dic, @"startTime")) {
        NSDate *startDate = [NSDate dateFromString:[EncodeStringFromDic(dic, @"startTime") substringToIndex:10] withFormat:@"yyyy-MM-dd" ];
        NSString *startDateSting = [NSDate stringFromDate:startDate withFormat:@"yyyy-MM-dd" ];
        self.startTime = startDateSting;
    }
    if (EncodeStringFromDic(dic, @"endTime")) {
        NSDate *endDate = [NSDate dateFromString:[EncodeStringFromDic(dic, @"endTime") substringToIndex:10] withFormat:@"yyyy-MM-dd" ];
        NSString *endDateSting = [NSDate stringFromDate:endDate withFormat:@"yyyy-MM-dd" ];
        self.endTime = endDateSting;
    }
    self.preUsed = [EncodeStringFromDic(dic, @"preUsed")integerValue];
    self.notUse = [EncodeStringFromDic(dic, @"notUse")integerValue];
    self.overUsed = [EncodeStringFromDic(dic, @"overUsed")integerValue];
    self.used = [EncodeStringFromDic(dic, @"used")integerValue];
    self.obsolete = [EncodeStringFromDic(dic, @"obsolete")integerValue];
}

@end
