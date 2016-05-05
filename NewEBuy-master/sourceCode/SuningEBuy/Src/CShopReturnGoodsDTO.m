//
//  CShopReturnGoodsDTO.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopReturnGoodsDTO.h"

@implementation CShopReturnGoodsDTO
@synthesize expressId = _expressId;
@synthesize expressName = _expressName;

- (void)dealloc {
    
    
    TT_RELEASE_SAFELY(_expressId);
    TT_RELEASE_SAFELY(_expressName);
    
}


-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    
    NSString *__expressId = [dic objectForKey:@"expressId"];
    NSString *__expressName = [dic objectForKey:@"expressName"];
    

    
    if (NotNilAndNull(__expressId) && ![__expressId isEqualToString:@""]) {
        
        self.expressId = __expressId;
        
    }
    if (NotNilAndNull(__expressName) && ![__expressName isEqualToString:@""]) {
        
        self.expressName = __expressName;
        
    }
    
  
    
}


@end
