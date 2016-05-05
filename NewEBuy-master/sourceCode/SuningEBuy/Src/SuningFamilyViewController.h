//
//  SuningFamilyViewController.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-5.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "FamilyCell.h"
@interface SuningFamilyViewController : CommonViewController<FamilyCellDelegate>
{
    NSArray *dataSource;
    NSMutableArray *owners;
    NSMutableArray *others;
}

@end
