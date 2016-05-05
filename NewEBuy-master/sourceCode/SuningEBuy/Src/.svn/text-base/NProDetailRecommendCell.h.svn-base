//
//  NProDetailRecommendCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataProductBasic.h"
#import "RecommendDTO.h"

@protocol   NProDetailRecoCellDelegate;

@interface NProDetailRecommendCell : UITableViewCell<EGOImageViewExDelegate>

@property (nonatomic,weak) id<NProDetailRecoCellDelegate> delegate;

@property (nonatomic, strong) UIImageView           *separateLineImgView;

//商品名称
@property (nonatomic,strong) UILabel                *leftLabel;
@property (nonatomic,strong) UILabel                *rightLabel;
@property (nonatomic,strong) UILabel                *centerLabel;

//商品图片
@property (nonatomic,strong) EGOImageViewEx         *leftImageView;
@property (nonatomic,strong) EGOImageViewEx         *rightImageView;
@property (nonatomic,strong) EGOImageViewEx         *centerImageView;

//商品背景
@property (nonatomic,strong) UIImageView            *leftBackImageView;
@property (nonatomic,strong) UIImageView            *rightBackImageView;
@property (nonatomic,strong) UIImageView            *centerBackImageView;

//商品价格
@property (nonatomic,strong) UILabel                *leftPriceLabel;
@property (nonatomic,strong) UILabel                *rightPriceLabel;
@property (nonatomic,strong) UILabel                *centerPriceLabel;

//商品数据源
@property (nonatomic,strong) RecommendListDTO       *leftDto;
@property (nonatomic,strong) RecommendListDTO       *rightDto;
@property (nonatomic,strong) RecommendListDTO       *centerDto;


- (void) setItem:(RecommendListDTO *)leftDto
      centerItem:(RecommendListDTO *)centerDto
       rightItem:(RecommendListDTO *)rightDto
         withTag:(NSInteger)index;

//高度
+ (CGFloat) height:(RecommendListDTO *)item;

@end

@protocol NProDetailRecoCellDelegate <NSObject>

- (void)cellImageDidClicked:(DataProductBasic *)dto RecommendListDTO:(RecommendListDTO*)aRecommendListDTO;

@end
