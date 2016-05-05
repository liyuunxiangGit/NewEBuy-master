//
//  InsuranceDTO.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InsuranceDTO.h"

@implementation InsuranceDTO

@synthesize prdId = _prdId;
@synthesize insuranceName = _insuranceName;
@synthesize insuranceDetailInfo = _insuranceDetailInfo;
@synthesize salePrice = _salePrice;
@synthesize sellNum = _sellNum;
@synthesize supOrderId = _supOrderId;

@synthesize copyCount = _copyCount;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_prdId);
    TT_RELEASE_SAFELY(_insuranceName);
    TT_RELEASE_SAFELY(_insuranceDetailInfo);
    TT_RELEASE_SAFELY(_salePrice);
    TT_RELEASE_SAFELY(_sellNum);
    TT_RELEASE_SAFELY(_supOrderId);
}

- (id)init
{
    self = [super init];
    if (self) {
        _copyCount = CopyCountNone;
    }
    return self;
}

- (void)encodeFromDictionary:(NSDictionary *)items
{
    if (items == nil) {
        return;
    }
    
    
    NSString *__prdId = [items objectForKey:@"prdid"];
    if (NotNilAndNull(__prdId))   self.prdId = __prdId;
    
    NSString *__insuranceName = [items objectForKey:@"insuranceName"];
    if (NotNilAndNull(__insuranceName))   self.insuranceName = __insuranceName;
    
    NSString *__insuranceDetailInfo = [items objectForKey:@"insuranceDetailInfo"];
    if (NotNilAndNull(__insuranceDetailInfo))   self.insuranceDetailInfo = __insuranceDetailInfo;
    
    NSString *__salePrice = [items objectForKey:@"salePrice"];
    if (NotNilAndNull(__salePrice))   self.salePrice = __salePrice;
    
    NSString *__sellNum = [items objectForKey:@"sellNum"];
    if (NotNilAndNull(__sellNum))   self.sellNum = __sellNum;
    
    NSString *__supOrderId = [items objectForKey:@"supOrderId"];
    if (NotNilAndNull(__supOrderId))   self.supOrderId = __supOrderId;
}

- (id)copyWithZone:(NSZone *)zone
{
    InsuranceDTO *copyItem = [self.class allocWithZone:zone];
    
    copyItem.prdId = self.prdId;
    copyItem.insuranceName = self.insuranceName;
    copyItem.insuranceDetailInfo = self.insuranceDetailInfo;
    copyItem.salePrice = self.salePrice;
    copyItem.sellNum = self.sellNum;
    copyItem.copyCount = self.copyCount;
    copyItem.supOrderId = self.supOrderId;
    return copyItem;
}

- (void)setCopyCount:(CopyCount)copyCount
{
    if (copyCount == CopyCountSingle && [self.sellNum intValue] >= 1) {
        _copyCount = copyCount;
    }
    
    if (copyCount == CopyCountDouble && [self.sellNum intValue] >= 2) {
        _copyCount = copyCount;
    }
}

@end
