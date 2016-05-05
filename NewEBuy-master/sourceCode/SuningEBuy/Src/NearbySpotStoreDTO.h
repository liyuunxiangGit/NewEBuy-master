//
//  SuningStoreDTO.h
//  SuningEBuy
//
//  Created by Kristopher on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface NearbySpotStoreDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *storeCode;

@property (nonatomic, strong) NSString *storeName;

@property (nonatomic, strong) NSString *storeAddress;

@property (nonatomic, strong) NSString *distance;


@end
