//
//  StoreServiceDTO.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface StoreServiceDTO : BaseHttpDTO

@property (nonatomic, strong) NSString    *serviceId;

@property (nonatomic, strong) NSString    *serviceName;

@property (nonatomic, strong) NSString    *logoUrl;

@property (nonatomic, strong) NSString    *serveDescription;

@property (nonatomic, strong) NSString    *isTopService;

@end
