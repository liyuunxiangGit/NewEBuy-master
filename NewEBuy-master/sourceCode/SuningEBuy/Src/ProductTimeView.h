//
//  ProductTimeView.h
//  SuningEBuy
//
//  Created by YANG on 14-7-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTimeView : UIView

@property (nonatomic, strong) UILabel   *titleLbl;

@property (nonatomic, strong) UILabel   *dayLbl;

@property (nonatomic, strong) UILabel   *dayLbl1;

@property (nonatomic, strong) UILabel   *dayLbl2;

@property (nonatomic, strong) UILabel   *dayLbl3;

@property (nonatomic, strong) UILabel   *hourLbl1;

@property (nonatomic, strong) UILabel   *hourLbl2;

@property (nonatomic, strong) UILabel   *hourLbl3;

@property (nonatomic, strong) UILabel   *miniteLbl1;

@property (nonatomic, strong) UILabel   *miniteLbl2;

@property (nonatomic, strong) UILabel   *miniteLbl3;

@property (nonatomic, strong) UILabel   *secondsLbl1;

@property (nonatomic, strong) UILabel   *secondsLbl2;

@property (nonatomic, strong) UILabel   *secondsLbl3;

@property (nonatomic, strong) UILabel   *tipLabel;

@property (nonatomic, strong) UIImageView   *lineImgView;

- (void)calculagraphTime:(double)seconds;

- (void)setState:(NSInteger)state;

- (void)hiddenTimeLabel:(NSString *)tip;

@end
