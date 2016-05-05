//
//  GBShopDTO.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBConfig.h"

@interface GBShopDTO : NSObject
{
    @private
    
    NSString *_name;//酒店名称
    NSString *_area;//商业区
    NSString *_address;//地址
    NSString *_tel;//电话
    NSString *_star;//酒店星级
}

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString  *area;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *tel;
@property (nonatomic ,copy)NSString *star;
@property (nonatomic, strong)NSMutableArray *telList;

- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
