//
//  MYEbuyCoumonDTO.h
//  SuningEBuy
//
//  Created by DP on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "AppConstant.h"

@interface MYEbuyCoumonDTO : BaseHttpDTO{
    
    //券号
    NSNumber *serialNumber_;
    //券名称
	NSString *name_;
    //失效时间
	NSString *endTime_;
    //面值
    NSNumber *strparValue_;
    //单张易购券余额
    NSNumber *remainingAmount_;
    //券使用范围
    NSString *ticketCategory_;
    //券使用规则
    NSString *useRule_;

}

@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *strparValue;
@property (nonatomic, copy) NSString *remainingAmount;
@property (nonatomic, copy) NSString *ticketCategory;
@property (nonatomic, copy) NSString *useRule;
@property (nonatomic, copy) NSString *couponTemplateDesc;

@property (nonatomic)BOOL bExpend;//默认不展开  仅在ui时 使用
@end
