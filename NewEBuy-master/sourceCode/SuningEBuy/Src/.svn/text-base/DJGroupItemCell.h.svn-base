//
//  DJGroupItemCell.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculagraph.h"
#import "DJGroupListItemDTO.h"

@protocol DJGroupItemCellDelegate;

@interface DJGroupItemCell : UITableViewCell

@property (nonatomic, strong) Calculagraph *cal;
@property (nonatomic, weak) id<DJGroupItemCellDelegate> delegate;

- (void)setItem:(DJGroupListItemDTO *)item;
+ (CGFloat)height;

@end

@protocol DJGroupItemCellDelegate <NSObject>

- (void)joinGroup:(id)dto;

@end
