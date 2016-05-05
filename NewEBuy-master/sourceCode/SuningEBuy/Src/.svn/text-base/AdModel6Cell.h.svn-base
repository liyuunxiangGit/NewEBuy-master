//
//  AdModel6Cell.h
//  SuningEBuy
//
//  Created by xmy on 18/7/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  modified by zhangbeibei: 20141020  修改一行两个商品的模板，使商品图片顶到cell的左右边距，并且调整商品图片为正方形。

#import <UIKit/UIKit.h>

#import "UITableViewCellEx.h"
#import "InnerProductDTO.h"
#import "DataProductBasic.h"

@class AdModel6Cell;
@protocol Model6Delegate <NSObject>

- (void)cellImageDidClicked:(DataProductBasic *)dto;

@end


@interface AdModel6Cell : UITableViewCellEx<EGOImageViewExDelegate>
{
    id<Model6Delegate>   imageDidDelegate_;
    
    UILabel      *_leftLabel;
    UILabel      *_rightLabel;
    
    EGOImageViewEx *_leftImageView;
    EGOImageViewEx *_rightImageView;
    
    UIImageView   *_leftBackImageView;
    UIImageView   *_rightBackImageView;
    
    UILabel       *leftPriceLabel_;
    UILabel       *rightPriceLabel_;
    
    InnerProductDTO *leftDto_;
    InnerProductDTO *rightDto_;
       
}

@property (nonatomic,weak) id<Model6Delegate> imageDidDelegate;
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic, strong) EGOImageViewEx *leftPriceImageView;
@property (nonatomic, strong) EGOImageViewEx *rightPriceImageView;

@property (nonatomic, strong) UILabel *leftHintLabel;
@property (nonatomic, strong) UILabel *rightHintLabel;

@property (nonatomic,strong) EGOImageViewEx *leftImageView;
@property (nonatomic,strong) EGOImageViewEx *rightImageView;

@property (nonatomic,strong) UIImageView *leftBackImageView;
@property (nonatomic,strong) UIImageView *rightBackImageView;

@property (nonatomic,strong) UIView *leftBackgroundView;
@property (nonatomic,strong) UIView *rightBackgroundView;

@property (nonatomic,strong) UILabel             *leftPriceLabel;
@property (nonatomic,strong) UILabel             *rightPriceLabel;

@property (nonatomic,strong) InnerProductDTO     *leftDto;
@property (nonatomic,strong) InnerProductDTO     *rightDto;

@property (nonatomic,strong) UIImageView *salesLeftSmallImage;
@property (nonatomic,strong) UIImageView *salesRightSmallImage;

@property (nonatomic,strong) UILabel *salesLeftBigBangName;
@property (nonatomic,strong) UILabel *salesRightBigBangName;


- (void) setItem:(InnerProductDTO *)leftDto  rightItem:(InnerProductDTO *)rightDto withTag:(NSInteger)index;

//+ (CGFloat) height:(InnerProductDTO *)item;

+ (CGFloat) height;

@end
