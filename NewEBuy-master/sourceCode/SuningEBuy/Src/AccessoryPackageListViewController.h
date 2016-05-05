//
//  AccessoryPackageListViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "DataProductBasic.h"
#import "AccessoryProductListCell.h"

@interface AccessoryPackageListViewController : CommonViewController<AccessoryProductCheckDelegate>

@property (nonatomic, strong) DataProductBasic *baseProductDTO;
@property (nonatomic, strong) NSArray *accessoryList;

@end
