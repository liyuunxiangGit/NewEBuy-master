//
//  CatePickSecondViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"
#import "SearchParamDTO.h"
#import "SearchCateDTO.h"

@class CatePickViewController;

@interface CatePickSecondViewController : PickCommonViewController
{

}

@property (nonatomic, strong) SearchCateDTO *cateDTO;
@property (nonatomic, weak) CatePickViewController *catePicker;

- (id)initWithCateDTO:(SearchCateDTO *)cate;

@end
