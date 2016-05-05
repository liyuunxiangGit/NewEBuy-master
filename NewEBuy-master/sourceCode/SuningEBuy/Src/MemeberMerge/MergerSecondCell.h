//
//  MergerSecondCell.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-10-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCertainViewController.h"
@interface MergerSecondCell : SNUITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UIButton          *selectButton;
@property (nonatomic, strong) UILabel           *firstCellLable;

@property (nonatomic, strong) UITextField       *phoneNumberTextField;
@property (nonatomic, strong) CardNoListDTO     *item;

@end
