//
//  GroupPurchaseDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-26.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "GroupPurchaseDTO.h"
#import "ProductUtil.h"

@implementation GroupPurchaseDTO

@synthesize purchaseState = purchaseState_;
@synthesize grppurId = _grppurId;
@synthesize partName = _partName;
@synthesize partNumber = _partNumber;
@synthesize startTime = _startTime;
@synthesize voucherAmount = _voucherAmount;
@synthesize productId = _productId;
@synthesize productDesc = _productDesc;
@synthesize salesOrg = _salesOrg;
@synthesize vendor = _vendor;
@synthesize depot = _depot;
@synthesize entryPrices = _entryPrices;
@synthesize currentTime = _currentTime;
@synthesize startTimeMilliSecond = _startTimeMilliSecond;
@synthesize endTimeMilliSecond = _endTimeMilliSecond;
@synthesize virtualGPFlag = _virtualGPFlag;
@synthesize virtualPrice = _virtualPrice;
@synthesize subscribeAmount = _subscribeAmount;
@synthesize adjustAmount = _adjustAmount;
@synthesize perPersonQty = _perPersonQty;
@synthesize minQty = _minQty;
@synthesize maxQty = _maxQty;
@synthesize minReward = _minReward;
@synthesize maxReward = _maxReward;
@synthesize limitQty = _limitQty;
@synthesize applyFulledFlag = _applyFulledFlag;
@synthesize gpFinishFlag = _gpFinishFlag;
@synthesize imageURL = _imageURL;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_grppurId);
    TT_RELEASE_SAFELY(_partName);
    TT_RELEASE_SAFELY(_partNumber);
    TT_RELEASE_SAFELY(_startTime);
    TT_RELEASE_SAFELY(_voucherAmount);
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_productDesc);
    TT_RELEASE_SAFELY(_salesOrg);
    TT_RELEASE_SAFELY(_vendor);
    TT_RELEASE_SAFELY(_depot);
    TT_RELEASE_SAFELY(_entryPrices);
    TT_RELEASE_SAFELY(_currentTime);
    TT_RELEASE_SAFELY(_startTimeMilliSecond);
    TT_RELEASE_SAFELY(_endTimeMilliSecond);
    TT_RELEASE_SAFELY(_virtualGPFlag);
    TT_RELEASE_SAFELY(_virtualPrice);
    TT_RELEASE_SAFELY(_subscribeAmount);
    TT_RELEASE_SAFELY(_adjustAmount);
    TT_RELEASE_SAFELY(_perPersonQty);
    TT_RELEASE_SAFELY(_minQty);
    TT_RELEASE_SAFELY(_maxQty);
    TT_RELEASE_SAFELY(_minReward);
    TT_RELEASE_SAFELY(_maxReward);
    TT_RELEASE_SAFELY(_limitQty);
    TT_RELEASE_SAFELY(_applyFulledFlag);
    TT_RELEASE_SAFELY(_gpFinishFlag);
    TT_RELEASE_SAFELY(_imageURL);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    
    NSString *__grppurId = [dic objectForKey:@"grppur_id"];
    if (NotNilAndNull(__grppurId)) self.grppurId = __grppurId;
    
    NSString *__partName = [dic objectForKey:@"partName"];
    if (NotNilAndNull(__partName))   self.partName = __partName;
    
    NSString *__partNumber = [dic objectForKey:@"partNumber"];
    if (NotNilAndNull(__partNumber)){
        NSString *trimmedString = [__partNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.partNumber = trimmedString;
    }
    
    NSString *__startTime = [dic objectForKey:@"startTime"];
    if (NotNilAndNull(__startTime))   self.startTime = __startTime;
    
    NSString *__voucherAmount = [dic objectForKey:@"voucherAmount"];
    if (NotNilAndNull(__voucherAmount))   self.voucherAmount = __voucherAmount;
    
    NSString *__productId = [dic objectForKey:@"productId"];
    if (NotNilAndNull(__productId))   self.productId = __productId;
    
    NSString *__productDesc = [dic objectForKey:@"productDesc"];
    if (NotNilAndNull(__productDesc))   self.productDesc = __productDesc;
    
    NSString *__salesOrg = [dic objectForKey:@"salesOrg"];
    if (NotNilAndNull(__salesOrg))   self.salesOrg = __salesOrg;
    
    NSString *__vendor = [dic objectForKey:@"vendor"];
    if (NotNilAndNull(__vendor))   self.vendor = __vendor;
    
    NSString *__depot = [dic objectForKey:@"depot"];
    if (NotNilAndNull(__depot))   self.depot = __depot;
    
    NSString *__entryPrices = [dic objectForKey:@"entryPrices"];
    if (NotNilAndNull(__entryPrices))   self.entryPrices = __entryPrices;
    
    NSString *__currentTime = [dic objectForKey:@"currentTime"];
    if (NotNilAndNull(__currentTime))   self.currentTime = __currentTime;
    
    NSString *__startTimeMilliSecond = [dic objectForKey:@"startTimeMillisecond"];
    if (NotNilAndNull(__startTimeMilliSecond))   self.startTimeMilliSecond = __startTimeMilliSecond;
    
    NSString *__endTimeMilliSecond = [dic objectForKey:@"endTimeMillisecond"];
    if (NotNilAndNull(__endTimeMilliSecond))   self.endTimeMilliSecond = __endTimeMilliSecond;
    
    NSString *__virtualGPFlag = [dic objectForKey:@"virtualGPFlag"];
    if (NotNilAndNull(__virtualGPFlag))   self.virtualGPFlag = __virtualGPFlag;
    
    NSString *__virtualPrice = [dic objectForKey:@"virtualPrice"];
    if (NotNilAndNull(__virtualPrice))   self.virtualPrice = __virtualPrice;
    
    NSString *__subscribeAmount = [dic objectForKey:@"subscribeAmount"];
    if (NotNilAndNull(__subscribeAmount))   self.subscribeAmount = __subscribeAmount;
    
    NSString *__adjustAmount = [dic objectForKey:@"adjustAmount"];
    if (NotNilAndNull(__adjustAmount))   self.adjustAmount = __adjustAmount;
    
    NSString *__perPersonQty = [dic objectForKey:@"perPersonQty"];
    if (NotNilAndNull(__perPersonQty))   self.perPersonQty = __perPersonQty;
    
    NSString *__minQty = [dic objectForKey:@"minQty"];
    if (NotNilAndNull(__minQty))   self.minQty = __minQty;
    
    NSString *__maxQty = [dic objectForKey:@"maxQty"];
    if (NotNilAndNull(__maxQty))   self.maxQty = __maxQty;
    
    NSString *__minReward = [dic objectForKey:@"minReward"];
    if (NotNilAndNull(__minReward))   self.minReward = __minReward;
    
    NSString *__maxReward = [dic objectForKey:@"maxReward"];
    if (NotNilAndNull(__maxReward))   self.maxReward = __maxReward;
    
    NSString *__limitQty = [dic objectForKey:@"limitQty"];
    if (NotNilAndNull(__limitQty))   self.limitQty = __limitQty;
    
    NSString *__applyFulledFlag = [dic objectForKey:@"applyFulledFlag"];
    if (NotNilAndNull(__applyFulledFlag))   self.applyFulledFlag = __applyFulledFlag;
    
    NSString *__gpFinishFlag = [dic objectForKey:@"gpFinishFlag"];
    if (NotNilAndNull(__gpFinishFlag))   self.gpFinishFlag = __gpFinishFlag;
    
    
    NSURL *imageUrl = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize200x200];
    self.imageURL = imageUrl;
    [self checkState];
}


- (void)checkState
{
    //先判断距离开始时间如果为负，状态OnSale
    if (self.startTimeMilliSecond && [self.startTimeMilliSecond floatValue] < 0)
    {
        self.purchaseState = OnSale;
    }
    //如果距离开始时间的值为正，状态为ReadyForSale ，即将开始
    else if (self.startTimeMilliSecond && [self.startTimeMilliSecond floatValue] >= 0)
    {
        self.purchaseState = ReadyForSale;
    }
    //团购已满，标记为结束
    if (_applyFulledFlag && [_applyFulledFlag isEqualToString:@"true"])
    {
        self.purchaseState = SaleOut;
    }
    
    //团购结束也标记为结束
    if (_gpFinishFlag && [_gpFinishFlag isEqualToString:@"1"])
    {
        self.purchaseState = SaleOut;
    }
    
}

@end
