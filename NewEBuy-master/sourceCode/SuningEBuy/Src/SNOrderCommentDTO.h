//
//  SNOrderCommentDTO.h
//  SuningEBuy
//
//  Created by snping on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNOrderCommentDTO : NSObject

@property (nonatomic, strong)NSString *qualityStar;//商品满意度 1 – 5 数字
@property (nonatomic, strong)NSString *logisticStar;//物流满意度 1 – 5数字
@property (nonatomic, strong)NSString *serviceStar;//店员服务满意度 1 – 5 数字
@property (nonatomic, strong)NSString *anonFlag;//是否匿名评价 1是 0否
@property (nonatomic, strong)NSString *orderId;//订单号
@property (nonatomic, strong)NSString *orderItemId;//订单行号
@property (nonatomic, strong)NSString *commodityCode;//商品编码
@property (nonatomic, strong)NSString *content;//使用心得，不超过500字，超出将被截取（实际请按标准140个字来）。

@end
