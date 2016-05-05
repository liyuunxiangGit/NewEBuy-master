//
//  JPInfoDTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-1-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

typedef enum {
    FirstPrise  = 1,
    SecondPrise = 2,
    ThirdPrise  = 3,
    FourthPrise = 4,    
    JoinPrise   = 5,    //参与奖
}SNPrise;

@interface JPInfoDTO : BaseHttpDTO

@property (nonatomic, copy) NSString *jpId;
@property (nonatomic, copy) NSString *jpPrice;
@property (nonatomic, copy) NSString *jpName;
@property (nonatomic, copy) NSString *jpDate;
@property (nonatomic, copy) NSString *jpMessage;

@property (nonatomic, assign) SNPrise priseLevel;

@end
