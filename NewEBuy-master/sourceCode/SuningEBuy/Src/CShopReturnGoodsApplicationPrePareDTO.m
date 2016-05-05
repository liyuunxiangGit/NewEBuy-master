//
//  CShopReturnGoodsApplicationPrePareDTO.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopReturnGoodsApplicationPrePareDTO.h"

@implementation CShopReturnGoodsApplicationPrePareDTO
@synthesize type = _type;
@synthesize orderId = _orderId;
@synthesize orderItemsId = _orderItemsId;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_type);
    TT_RELEASE_SAFELY(_orderItemsId);
    TT_RELEASE_SAFELY(_orderId);
    
}


-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__type = [dic objectForKey:@"type"];
    NSString *__orderId = [dic objectForKey:@"orderId"];
    NSString *__orderItemsId = [dic objectForKey:@"orderItemsId"];
    
    if (NotNilAndNull(__type) && ![__type isEqualToString:@""]) {
        
        self.type = __type;
        
    }
    
    if (NotNilAndNull(__orderId) && ![__orderId isEqualToString:@""]) {
        
        self.orderId = __orderId;
        
    }
    if (NotNilAndNull(__orderItemsId) && ![__orderItemsId isEqualToString:@""]) {
        
        self.orderItemsId = __orderItemsId;
        
    }
    
}

@end
