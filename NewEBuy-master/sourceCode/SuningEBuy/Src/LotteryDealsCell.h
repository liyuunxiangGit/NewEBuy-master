//
//  LotteryDealsCell.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//  彩票订单列表cell类

#import <UIKit/UIKit.h>
#import "LotteryOrderDto.h"
#import "LotteryDealsDto.h"
#import "OHAttributedLabel.h"
#import "LotteryDealsSerialNumberDto.h"




@interface LotteryDealsCell : UITableViewCell



@property (nonatomic, strong)       UIImageView        * logo;
@property (nonatomic, strong)       UILabel            * periods;    //期数
@property (nonatomic, strong)       UILabel            * boughtdate; //购买日期
@property (nonatomic, strong)       UILabel            * totalMoney; //钱数
@property (nonatomic, strong)       UILabel            * state;    //订单状态
@property (nonatomic, strong)       UILabel            * dealsType;  //订单类型
@property (nonatomic, strong)       UIImageView        * cutline;    //分割线
@property (nonatomic, strong)       UIImageView        * arrow;      //箭头
-(void)setItems:(id) dto;
@end
