//
//  BigViewModelCell.h
//  SuningEBuy
//
//  Created by chupeng on 14-8-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigViewModelCellSubView.h"

@protocol BigViewModelCellDelegate <NSObject>
- (void)didTappedBigModelView:(DataProductBasic *)dto;
@end

@interface BigViewModelCell : UITableViewCell
@property (nonatomic, weak)   id <BigViewModelCellDelegate> delegate;
@property (nonatomic, strong) BigViewModelCellSubView *leftView;
@property (nonatomic, strong) BigViewModelCellSubView *rightView;

- (void)setLeftItem:(DataProductBasic *)item;
- (void)setRightItem:(DataProductBasic *)item;
@end
