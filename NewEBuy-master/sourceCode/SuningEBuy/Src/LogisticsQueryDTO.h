//
//  LogisticsQueryDTO.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface OrderItemDTO : BaseHttpDTO

@property(nonatomic,strong)NSString *orderItemId;
@property(nonatomic,strong)NSString *productCode;
@property(nonatomic,strong)NSString *productId;
@property(nonatomic,strong)NSString *productName;
@property(nonatomic,strong)NSString *quantityInIntValue;
@property(nonatomic,strong)NSString *totalProduct;
@end

@interface LogisticsQueryDTO : BaseHttpDTO


@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *prepayAmount;
@property(nonatomic,strong)NSString *lastUpdate;
@property(nonatomic,strong)NSString *oiStatus;
@property(nonatomic,strong)NSMutableArray *orderItemArray;

@end
