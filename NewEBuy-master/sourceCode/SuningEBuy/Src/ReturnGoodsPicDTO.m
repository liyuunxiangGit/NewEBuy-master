//
//  ReturnGoodsPicDTO.m
//  SuningEBuy
//
//  Created by zl on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnGoodsPicDTO.h"

@implementation ReturnGoodsPicDTO
- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_picId);
    TT_RELEASE_SAFELY(_picData);
}
-(void)encodeFromDictionary:(NSDictionary *)dic
{
    
	if (![dic isKindOfClass:[NSDictionary class]])
    {
        return;
    }
}
@end
