//
//  GBVoucherSingleInfo.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBVoucherSingleInfoDTO.h"

@implementation GBVoucherSingleInfoDTO
@synthesize voucherCode = _voucherCode;
@synthesize voucherPasswd = _voucherPasswd;
@synthesize status = _status;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize voucherOrderId = _voucherOrderId;
@synthesize spOrderId = _spOrderId;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    self.voucherCode = EncodeStringFromDic(dic, @"voucherCode");
    self.voucherPasswd = EncodeStringFromDic(dic, @"voucherPasswd");
    self.status = [EncodeStringFromDic(dic, @"status")integerValue];
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
    self.voucherOrderId = EncodeStringFromDic(dic, @"voucherOrderId");
    self.spOrderId = EncodeStringFromDic(dic, @"spOrderId");
    self.orderItemId = EncodeStringFromDic(dic, @"orderItemId");
}
@end
