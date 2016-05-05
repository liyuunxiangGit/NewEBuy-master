//
//  baoXianItemCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"
#import "PickerButton.h"

@class OrderSubmitRootViewController;

@interface baoXianItemCell : UITableViewCellEx <PickerButtonDelegate>

@property(nonatomic,strong) UILabel    *baoxianxuanzeLbl;
@property(nonatomic,strong) UIView     *whiteBackView;
@property(nonatomic,strong) UILabel    *baoXianNameLbl;
@property(nonatomic,strong) UILabel    *baoXianPriceLbl;
@property(nonatomic,strong) UILabel    *baoXianSuningLbl;


@property(nonatomic, strong) NSArray   *insuranceList;//险种列表

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
                   controller:(OrderSubmitRootViewController *)controller;

- (void)setItem;

+ (CGFloat)height:(OrderSubmitRootViewController *)controller;

@end
