//
//  AirlineInfoCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFOrderDetailDTO.h"

@protocol AirlineInfoCellDelegate;

@interface AirlineInfoCell : UITableViewCell
{
    PFOrderDetailDTO *_orderDetailDTO;
    
    NSDictionary     *_typeInfo;
}

@property (nonatomic, strong) PFOrderDetailDTO *orderDetailDTO;
@property (nonatomic, strong) NSDictionary *typeInfo;
@property (nonatomic, weak) id<AirlineInfoCellDelegate> delegate;

- (void)setItem:(PFOrderDetailDTO *)dto dataType:(NSDictionary *)type;

+ (CGFloat)height;

@end


@protocol AirlineInfoCellDelegate <NSObject>

- (void)showRuleInfo:(AirlineInfoDTO *)airlineRule;

@end