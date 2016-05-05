//
//  GroupProductSImpleView.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-29.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupPurchaseDTO.h"
#import "PurchaseConstant.h"

@interface GroupProductSimpleView : UIView
{
@private
    UILabel     *leavingTimeLabel_;
    
    GroupPurchaseDTO    *groupDTO_;
}

@property (nonatomic, strong) UILabel *leavingTimeLabel;


- (void)setTime:(CGFloat)seconds;

- (void)setItem:(GroupPurchaseDTO *)groupDTO;


- (void)reloadView;

@end
