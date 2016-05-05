//
//  ReturnGoodsStatusDTO.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-8-8.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "ReturnGoodsQueryDTO.h"

@interface ReturnGoodsStatusDTO : BaseHttpDTO

{
    
    
}


@property    (nonatomic, copy)  NSString    *returnTime;      //退货处理时间
@property    (nonatomic, copy)  NSString    *returnRecord;    //退货处理详情
@property    (nonatomic, copy)  NSString    *timeAndRecord;   //退货时间以及此时的详情

@end
