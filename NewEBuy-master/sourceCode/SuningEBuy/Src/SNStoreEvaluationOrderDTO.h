//
//  SNStoreEvaluationOrderDTO.h
//  SuningEBuy
//
//  Created by snping on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNStoreEvaluationOrderDTO : NSObject

@property (nonatomic,strong)NSString *omsOrderId;//"000140150593",   // 订单号
@property (nonatomic,strong)NSString *omsOrderItemId;//"00014015059301", // 订单行号
@property (nonatomic,strong)NSString *commodityCode;//"912412", // 商品编码
@property (nonatomic,strong)NSString *commodityName; //"商品名称", // 商品名称
@property (nonatomic,strong)NSString *supplierCode;// 保留字段、暂时为空
@property (nonatomic,strong)NSString *orderTime;//"2014-10-22 11:27:43" // 订单时间

-(void)parseOrderItmFromDictionary:(NSDictionary *)dic;

@end
