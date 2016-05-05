//
//  MYEbuyCouponCell.h
//  SuningEBuy
//
//  Created by DP on 3/11/12.
//  Copyright (c) 2012 __zhaofk__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import <UIKit/UIKit.h>
#import "MYEbuyCoumonDTO.h"

@interface MYEbuyCouponCell : UITableViewCellEx{
    
    //易购券接口dto
    MYEbuyCoumonDTO *_item;
    
    //易购券名称
    UILabel    *_nameLbl;
    
    
    //易购券过期日期
    UILabel    *_endDateLbl;
    UILabel    *_desEndDateLbl;
    
    //面值
    UILabel    *_strParValueLbl;
    UILabel    *_desStrParValueLbl;
    
    //余额
    UILabel    *_remainingLbl;
    UILabel    *_desRemainingLbl;
    
    //券使用范围
    UILabel    *_userRangLbl;
    UILabel    *_desUserRangLbl;
}

@property(nonatomic,strong) MYEbuyCoumonDTO *item;

@property(nonatomic,strong) UILabel    *nameLbl;

@property(nonatomic,strong) UILabel    *endDateLbl;
@property(nonatomic,strong) UILabel    *desEndDateLbl;

@property(nonatomic,strong) UILabel    *strParValueLbl;
@property(nonatomic,strong) UILabel    *desStrParValueLbl;

@property(nonatomic,strong) UILabel    *remainingLbl;
@property(nonatomic,strong) UILabel    *desRemainingLbl;

@property(nonatomic,strong) UILabel    *userRangLbl;
@property(nonatomic,strong) UILabel    *desUserRangLbl;

@property(nonatomic) BOOL hiddenRemainLab;

//将请求的数据存放在对应的dto中
-(void) setItem:(MYEbuyCoumonDTO *)aItem;

+ (CGFloat)setMyEbuyCouponCellHeight:(MYEbuyCoumonDTO *)aItem;

@end
