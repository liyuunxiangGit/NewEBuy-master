//
//  HotelBusinessCircleDTO.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-4.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface HotelBusinessCircleDTO : BaseHttpDTO{
    
    NSString *locationId_;        //位置id
    NSString *locationName_;      //位置名称
    NSString *loactionType_;      //位置类型
    
}

@property(nonatomic,copy) NSString *locationId;        //位置id
@property(nonatomic,copy) NSString *locationName;      //位置名称
@property(nonatomic,copy) NSString *loactionType;      //位置类型


@end
