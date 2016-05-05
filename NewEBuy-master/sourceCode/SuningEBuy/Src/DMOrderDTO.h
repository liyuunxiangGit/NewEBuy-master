//
//  DMOrderDTO.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

typedef enum {
    
    DMORDER = 1,
    DEVICETAIK,
    TWO_DIMCode
    
}ActivityFromType;

@interface DMOrderResultDTO : BaseHttpDTO{
    
}


@property(nonatomic,strong)NSString *dmPictureUrlStr;
@property(nonatomic,strong)NSString *adId;
@property(nonatomic,strong)NSString *adTypeCode;
@property(nonatomic,strong)NSString *activityTitle;
@property(nonatomic,strong)NSString *activityRule;
@property(nonatomic,strong)NSString *activityPictureUrlStr;
@property(nonatomic,strong)NSString *dmId;
@end

@interface DMOrderDTO : NSObject{
    
}


@property(nonatomic,strong)NSString *platform;
@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *provinceId;
@property(nonatomic,strong)NSString *cityId;
@property(nonatomic,strong)NSString *districtId;
@property(nonatomic,strong)NSString *storeId;
@property(nonatomic,strong)NSString *dmType;
@end
