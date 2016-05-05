//
//  LotteryPayCell.h
//  SuningEBuy
//
//  Created by david david on 12-6-30.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "CommonViewController.h"

@protocol LotteryPayCellDelegate;


@interface LotteryPayCell : UITableViewCell


@property (nonatomic,copy)   NSString    *keyString;
@property (nonatomic,copy)   NSString    *valueString;
@property (nonatomic,strong) UILabel     *keyLbl;
@property (nonatomic,strong) UILabel     *valueLbl;
@property (nonatomic,strong) UIColor     *valueLblColor;
@property (nonatomic,copy)   NSString    *isPay;         //根据该标志位判断是否为支付cell: 1.isUnionpay 手机银联支付 2.isNotPay不是
@property (nonatomic,strong) UIImageView  *arrowView;


-(void)setItem:(NSDictionary *)dic;

@end


