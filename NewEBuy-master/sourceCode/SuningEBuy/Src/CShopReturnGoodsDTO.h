//
//  CShopReturnGoodsDTO.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface CShopReturnGoodsDTO : BaseHttpDTO


@property (nonatomic, copy)    NSString     *expressId;     //快递编号
@property (nonatomic, copy)    NSString     *expressName;    //快递名称

@end
