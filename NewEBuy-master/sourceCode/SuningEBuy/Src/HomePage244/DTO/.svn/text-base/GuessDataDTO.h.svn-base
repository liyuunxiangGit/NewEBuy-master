//
//  GuessDataDTO.h
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuessDataDTO : NSObject

//推荐商品ID
@property (nonatomic,strong) NSString       *productId;
//推荐商品编码
@property (nonatomic,strong) NSString       *productCode;
//推荐商品名称
@property (nonatomic,strong) NSString       *productName;
//推荐商品描述
@property (nonatomic,strong) NSString       *productDescription;
//推荐商品价格
@property (nonatomic,strong) NSString       *productPrice;
//供应商ID
@property (nonatomic,strong) NSString       *supplierId;
//单件商品占所有商品的购买占比
@property (nonatomic,strong) NSString       *percentage;
//是否是人工干预的数据（1是人工干预0,2是算法）和请求数据的版本（1A、1B）
@property (nonatomic,strong) NSString       *handWork;

- (void)parseFromDict:(NSDictionary *)dict;

@end
