//
//  LianBanFloorDTO.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "LianBanFloorDTO.h"
#import "HomeProductDTO.h"

@implementation LianBanFloorDTO

- (void)parseFromDict:(NSDictionary *)dict {
    if (IsNilOrNull(dict)) {
        return;
    }
    
    self.orderNO = EncodeStringFromDic(dict, @"orderno");
    NSDictionary *rowHead = [dict objectForKey:@"rowhead"];
    if (NotNilAndNull(rowHead)) {
        self.showStyle = EncodeStringFromDic(rowHead, @"showstyle");
        self.title = EncodeStringFromDic(rowHead, @"title");
        self.bgColor = EncodeStringFromDic(rowHead, @"bgcolor");
        self.bgImg = EncodeStringFromDic(rowHead, @"bgimg");
    }

    
    NSArray *productList = (NSArray *)[dict objectForKey:@"productlist"];
    if (!IsArrEmpty(productList)) {
        NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:[productList count]];
        @autoreleasepool {
            for (int i = 0; i <[productList count] ; i++) {
                HomeProductDTO *dto = [[HomeProductDTO alloc] init];
                [dto parseFromDict:(NSDictionary *)[productList objectAtIndex:i]];
                [resultArray addObject:dto];
            }
        }

        self.productArray = resultArray;
    }
}

@end
