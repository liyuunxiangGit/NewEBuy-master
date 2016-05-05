//
//  TotalPriceView.h
//  SuningEBuy
//
//  Created by  zhang jian on 14-1-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalPriceView : UIView

@property (nonatomic, strong) UILabel       *totalNameLabel;
@property (nonatomic, strong) UILabel       *totalPriceLabel;
@property (nonatomic, strong) UILabel       *farPriceLabel;

//刷新价格
- (void)setTotalPrice:(NSString *)totalPrice farPrice:(NSString *)farPrice;

//高度
+ (CGFloat)heightOfView;

@end
