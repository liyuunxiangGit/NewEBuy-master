//
//  CShopReturnGoodsApplicationPrePareDTO.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface CShopReturnGoodsApplicationPrePareDTO : BaseHttpDTO

@property (nonatomic, copy)    NSString     *type;          //"th"固定值
@property (nonatomic, copy)    NSString     *orderId;       //订单id
@property (nonatomic, copy)    NSString     *orderItemsId;  //订单行id
@end
