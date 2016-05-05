//
//  VoiceActiveDTO.h
//  SuningEBuy
//
//  Created by JackyWu on 14-10-30.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface VoiceActiveDTO : BaseHttpDTO

@property (nonatomic,strong) NSString  *errmsg;
@property (nonatomic,strong) NSString  *activeTypeID;
@property (nonatomic,strong) NSString  *activeID;
@property (nonatomic,assign) BOOL       isActity;
@property (nonatomic,strong) NSString  *actityType;
@property (nonatomic,strong) NSString  *adTypeID;
@property (nonatomic,strong) NSString  *adID;
@property (nonatomic,strong) NSString   *wapUrl;
@property (nonatomic,strong) NSString   *value2;
@property (nonatomic,strong) NSString   *state;

@end
