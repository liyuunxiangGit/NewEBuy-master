//
//  CouponModel.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

- (NSDictionary *)attributeMapDictionary {
    
    
    NSDictionary *mapAtt =@{
                            @"couponName": @"@couponName",
                            @"couponNo": @"@couponNo",
                            @"expiryDate": @"@expiryDate",
                            @"remainMoney": @"@remainMoney",
                            @"isExclusion": @"@isExclusion",
                            @"isControl": @"@isControl",
                            @"totalMoney":@"@totalMoney"
                            
                            };
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic {
    //将字典数据根据映射关系填充到当前对象的属性上。
    [self setTheAttributes:dataDic];
    
}

- (void)setTheAttributes:(NSDictionary*)dataDic{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[dataDic count]];
        for (NSString *key in dataDic) {
            [dic setValue:key forKey:key];
            attrMapDic = dic;
        }
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL sel = [self getSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
			NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            id attributeValue = [dataDic objectForKey:dataDicKey];
            
            //            if (attributeValue == nil) {
            //                if ([attributeName isEqualToString:@"body"]) {
            //                    continue;
            //                }
            //                attributeValue = @"";
            //            }
            
			[self performSelectorOnMainThread:sel
                                   withObject:attributeValue
                                waitUntilDone:[NSThread isMainThread]];		
		}
	}
}

- (SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}

@end
