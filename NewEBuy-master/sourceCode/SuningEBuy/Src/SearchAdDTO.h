//
//  SearchAdDTO.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-5-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface SearchAdDTO : BaseHttpDTO
{
    NSString *advertiseId_;
    NSString *position_;
    NSString *model_;
    NSString *activeName_;
    NSString *bigImageURL_;
    NSString *innerImageURL_;
    NSString *define_;
    NSString *backgroundURL_;
    NSString *activeRule_;
}

@property (nonatomic, copy) NSString *advertiseId;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *activeName;
@property (nonatomic, copy) NSString *bigImageURL;
@property (nonatomic, copy) NSString *innerImageURL;
@property (nonatomic, copy) NSString *define;
@property (nonatomic, copy) NSString *backgroundURL;
@property (nonatomic, copy) NSString *activeRule;
@end
