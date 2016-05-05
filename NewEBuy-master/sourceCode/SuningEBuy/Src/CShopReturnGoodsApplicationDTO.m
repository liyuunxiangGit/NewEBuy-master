//
//  CShopReturnGoodsApplicationDTO.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopReturnGoodsApplicationDTO.h"

@implementation CShopReturnGoodsApplicationDTO

@synthesize orderId = _orderId;
@synthesize orderItemsId = _orderItemsId;
@synthesize thxqh = _thxqh;
@synthesize thyy = _thyy;
@synthesize thsm = _thsm;
@synthesize tkbs = _tkbs;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderItemsId);
    TT_RELEASE_SAFELY(_thxqh);
    TT_RELEASE_SAFELY(_thyy);
    TT_RELEASE_SAFELY(_thsm);
    TT_RELEASE_SAFELY(_tkbs);
    
}


-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__orderId = [dic objectForKey:@"orderId"];
    NSString *__orderItemsId = [dic objectForKey:@"orderItemsId"];
    NSString *__thxqh = [dic objectForKey:@"thxqh"];
    NSString *__thyy = [dic objectForKey:@"thyy"];
    NSString *__thsm = [dic objectForKey:@"thsm"];
    NSString *__tkbs = [dic objectForKey:@"tkbs"];
    
    if (NotNilAndNull(__orderId) && ![__orderId isEqualToString:@""]) {
        
        self.orderId = __orderId;
        
    }
    if (NotNilAndNull(__orderItemsId) && ![__orderItemsId isEqualToString:@""]) {
        
        self.orderItemsId = __orderItemsId;
        
    }
    if (NotNilAndNull(__thxqh) && ![__thxqh isEqualToString:@""])
    {
        self.thxqh = __thxqh;
    }
    if (NotNilAndNull(__thyy) && ![__thyy isEqualToString:@""])
    {
        self.thyy = __thyy;
    }
    if (NotNilAndNull(__thsm) && ![__thsm isEqualToString:@""])
    {
        self.thsm = __thsm;
    }
    if (NotNilAndNull(__tkbs) && ![__tkbs isEqualToString:@""])
    {
        self.tkbs = __tkbs;
    }
    
}

@end
