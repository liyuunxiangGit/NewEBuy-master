//
//  BigImageTypeDTO.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface BigImageTypeDTO : BaseHttpDTO

@property (nonatomic,copy) NSString *typeId;//1单图，2多图文

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *publishTime;

@property (nonatomic,copy) NSString *imgUrl;

@property (nonatomic,copy) NSString *summary;

@property (nonatomic,copy) NSString *infoId;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
