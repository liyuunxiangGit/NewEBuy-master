//
//  BackBarView.h
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackBarView : UIView

@property(nonatomic,strong) UIButton    *backBtn;
@property(nonatomic,strong) UILabel     *oneLbl;
@property(nonatomic,strong) UILabel     *twoLbl;
@property(nonatomic,strong) UIButton    *submitBtn;

-(void)refreshBar:(NSString *)leftItem
       middleItem:(NSString *)middleItem
        rightItem:(NSString *)rightItem;
@end
