//
//  CityPickViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"
#import "AddressInfoDTO.h"

@interface CityPickViewController : PickCommonViewController
{
    NSInteger selectCityIndex;
}

@property (nonatomic, strong) NSArray *cityList;

@property (nonatomic, strong) AddressInfoDTO *provinceDTO;

- (id)initWithProvince:(AddressInfoDTO *)province;


@end
