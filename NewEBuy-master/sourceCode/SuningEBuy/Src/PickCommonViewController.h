//
//  PickCommonViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNPopoverCommonViewController.h"
#import "SearchFilterDelegate.h"
#import "SearchParamDTO.h"

@interface PickCommonViewController : SNPopoverCommonViewController
{
    id<SearchFilterDelegate> __weak _delegate;
}

@property (nonatomic, weak) id<SearchFilterDelegate> delegate;
@property (nonatomic, strong) UIImageView *checkMarkView;



@end
