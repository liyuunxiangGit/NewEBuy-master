//
//  BigViewModelCellSubView.h
//  SuningEBuy
//
//  Created by chupeng on 14-8-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EvaluationView.h"
#import "DataProductBasic.h"
#import "SNSwitch.h"

@interface BigViewModelCellSubView : UIView


@property (nonatomic, strong) EGOImageView *priceImageView;

@property (nonatomic, strong) EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *productNameLabel;

//促销标签，分别是抢，团，促，降,顺序是固定的
@property (nonatomic, strong) UIImageView *qiangImgView;
@property (nonatomic, strong) UIImageView *tuanImgView;
@property (nonatomic, strong) UIImageView *quanImgView;
@property (nonatomic, strong) UIImageView *jiangImgView;
@property (nonatomic, strong) UIImageView *dajuhuiImgView;
@property (nonatomic, strong) UILabel     *priceOfPromotionLabel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, weak) DataProductBasic *dto;
- (void)setItem:(DataProductBasic *)item;
@end
