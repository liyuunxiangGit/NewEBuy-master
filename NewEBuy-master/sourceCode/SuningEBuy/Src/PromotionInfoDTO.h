//
//  PromotionInfoDTO.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface PromotionInfoDTO : BaseHttpDTO
@property (nonatomic, copy) NSString    *elementId;

@property (nonatomic, copy) NSString    *areaIdenty;

@property (nonatomic, copy) NSString    *linkUrl;

@property (nonatomic, copy) NSString    *elementName;

@property (nonatomic, copy) NSString    *elementDesc;

@property (nonatomic, copy) NSString    *elementSeq;

@property (nonatomic, copy) NSString    *imgUrl;

@property (nonatomic, copy) NSString    *type;

@property (nonatomic, assign) BOOL      isRead;

@end
