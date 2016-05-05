//
//  ProvincePickViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"

@interface ProvincePickViewController : PickCommonViewController
{
    BOOL    isProvinceLoaded;
}

@property (nonatomic, strong) NSArray *provinceList;

- (id)init;

@end
