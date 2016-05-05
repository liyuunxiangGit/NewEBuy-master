//
//  ExCouponDto.h
//  SuningEBuy
//
//  Created by david david on 12-6-21.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpDTO.h"

@interface ExCouponDto : BaseHttpDTO

@property(nonatomic,copy) NSString *billType;           //业务类型
@property(nonatomic,copy) NSString *billNo;         //销售单号
@property(nonatomic,copy) NSString *sellMoney;      //销售金额
@property(nonatomic,copy) NSString *batchMoney;    //变化金额
@property(nonatomic,copy) NSString *beginDate;      //起始日期
@property(nonatomic,copy) NSString *endDate;        //截至日期
@property(nonatomic,copy) NSString *processTime;    //操作时间



@end
