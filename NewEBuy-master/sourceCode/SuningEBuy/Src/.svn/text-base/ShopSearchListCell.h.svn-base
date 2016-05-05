//
//  ShopSearchListCell.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopSearchListDTO.h"
#import "EvaluationView.h"
@interface ShopSearchListCell : UITableViewCell

//灰色区控件
@property (nonatomic, strong) UIView  *grayBack;        //灰色底
@property (nonatomic, strong) UIView  *sepLine1;        //分割线
@property (nonatomic, strong) UIView  *sepLine2;        //分割线
@property (nonatomic, strong) UIView  *sepLine3;        //分割线
@property (nonatomic, strong) UILabel *labelShopName;   //旗舰店名
@property (nonatomic, strong) UIImageView *rightArrow;   //右箭头
@property (nonatomic, strong) UIImageView *upArrow1;
@property (nonatomic, strong) UIImageView *upArrow2;
@property (nonatomic, strong) UIImageView *upArrow3;
@property (nonatomic, strong) UILabel *descNumLabel; //描述分数
@property (nonatomic, strong) UILabel *logisticsScore; //物流分数
@property (nonatomic, strong) UILabel *productScore; //商品分数
@property (nonatomic, strong) UILabel *descLabel;    //"描述"文字
@property (nonatomic, strong) UILabel *logisticsLabel; //“物流”文字
@property (nonatomic, strong) UILabel *productLabel;   //"商品"文字


//白色区控件
@property (nonatomic, strong) EGOImageView *shopLogoView;      //logo
@property (nonatomic, strong) EvaluationView *starView;        //星
@property (nonatomic, strong) UILabel *supplySatisfyStarScore; //得分
@property (nonatomic, strong) UILabel *supplySatisfyStar; //"商家满意度"文字
@property (nonatomic, strong) UILabel *catalogLabel; //主营品类
@property (nonatomic, strong) UILabel *addressLabel; //所在地

- (void)setItem:(ShopSearchListDTO *)item;
@end
