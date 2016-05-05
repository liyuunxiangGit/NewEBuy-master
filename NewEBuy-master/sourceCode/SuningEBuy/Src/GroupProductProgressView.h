//
//  GroupProductProgressView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupPurchaseDTO.h"

@interface GroupProductProgressView : UIView


@property (nonatomic, strong) GroupPurchaseDTO *groupDTO;


- (void)setItem:(GroupPurchaseDTO *)dto;

int intpart(float xx);

@end
