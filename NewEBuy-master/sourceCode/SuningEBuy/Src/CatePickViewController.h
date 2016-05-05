//
//  CatePickViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"

@interface CatePickViewController : PickCommonViewController
{
    NSInteger   selectedIndex;
}

@property (nonatomic, strong) NSArray *categoryList;
@property (nonatomic, copy) NSString *selectCateId;

- (id)initWithCateList:(NSArray *)list;

@end
