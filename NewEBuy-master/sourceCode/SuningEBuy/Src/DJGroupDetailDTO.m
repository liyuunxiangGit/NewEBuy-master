//
//  DJGroupDetailDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailDTO.h"

@implementation DJGroupDetailDTO

@synthesize grpPurId = _grpPurId;
@synthesize warmupTime = _warmupTime;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;

@synthesize currentTime = _currentTime;
@synthesize partnumber = _partnumber;
@synthesize catentryId = _catentryId;
@synthesize productName = _productName;
@synthesize displayPrice = _displayPrice;

@synthesize virtualQty = _virtualQty;
@synthesize maxQty = _maxQty;
@synthesize usedQty = _usedQty;
@synthesize totalQty = _totalQty;

@synthesize netPrice = _netPrice;
@synthesize percentage = _percentage;
@synthesize adjustAmount = _adjustAmount;
@synthesize startFlag = _startFlag;

@synthesize startTimeSeconds = _startTimeSeconds;
@synthesize endTimeSeconds = _endTimeSeconds;

- (void)dealloc
{
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.grpPurId = EncodeStringFromDic(dic, @"grpPurId");
    self.warmupTime = EncodeStringFromDic(dic, @"warmupTime");
    self.startTime = EncodeStringFromDic(dic, @"startTime");
    self.endTime = EncodeStringFromDic(dic, @"endTime");
    
    self.currentTime = EncodeStringFromDic(dic, @"currentTime");
    self.partnumber = EncodeStringFromDic(dic, @"partnumber");
    self.catentryId = EncodeStringFromDic(dic, @"catentryId");
    self.productName = EncodeStringFromDic(dic, @"productName");
    self.displayPrice = EncodeStringFromDic(dic, @"displayPrice");
    
    self.virtualQty = EncodeStringFromDic(dic, @"virtualQty");
    self.maxQty = EncodeStringFromDic(dic, @"maxQty");
    self.usedQty = EncodeStringFromDic(dic, @"usedQty");
    self.totalQty = EncodeStringFromDic(dic, @"totalQty");
    
    self.netPrice = EncodeStringFromDic(dic, @"netPrice");
    self.percentage = EncodeStringFromDic(dic, @"percentage");
    self.adjustAmount = EncodeStringFromDic(dic, @"adjustAmount");
    self.startFlag = EncodeStringFromDic(dic, @"startFlag");
    [self checkState];
}

- (void)checkState
{
    if (!IsStrEmpty(self.startTime) && !IsStrEmpty(self.currentTime) && !IsStrEmpty(self.endTime))
    {
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp=[self.startTime substringToIndex:19];
        NSString *dateCurrentTimeTemp=[self.currentTime substringToIndex:19];
        NSString *dateEndTimeTemp=[self.endTime substringToIndex:19];
        
        NSDate *dateStartTime = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        self.startTimeSeconds = [dateStartTime timeIntervalSinceDate:serverTime];
        self.endTimeSeconds = [dateEndTime timeIntervalSinceDate:serverTime];
    }
}

@end
