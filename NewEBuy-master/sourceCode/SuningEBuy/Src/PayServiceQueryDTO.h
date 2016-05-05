//
//  PayServiceQueryDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface PayServiceQueryDTO : BaseHttpDTO
{
    NSString *_companyName;
    
    NSString *_orderId;
    
    NSString *_orderName;
    
    NSString *_orderNo;
    
    NSString *_payAmount;
    
    NSString *_payTime;
    
    NSString *_status;
    
    NSString *_statusName;
}

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *orderName;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *payAmount;

@property (nonatomic, copy) NSString *payTime;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *statusName;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
