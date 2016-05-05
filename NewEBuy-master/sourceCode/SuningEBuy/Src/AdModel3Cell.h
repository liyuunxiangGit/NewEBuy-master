//
//  AdModel3Cell.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"
#import "InnerProductDTO.h"
#import "DataProductBasic.h"

#import "SNActivityProductDTO.h"

@protocol Model3Delegate <NSObject>

- (void)cellImageDidClicked:(DataProductBasic *)dto;

@end


@interface AdModel3Cell : UITableViewCellEx<EGOImageViewExDelegate>{   
    
    id<Model3Delegate>   __weak imageDidDelegate_;
    
    UILabel      *_leftLabel;
    UILabel      *_rightLabel;
    UILabel      *_centerLabel;
    
    EGOImageViewEx *_leftImageView;
    EGOImageViewEx *_rightImageView;
    EGOImageViewEx *_centerImageView;
    
    UIImageView    *_leftBackImageView;
    UIImageView    *_rightBackImageView;
    UIImageView    *_centerBackImageView;
    
    UILabel       *_leftPriceLabel_;
    UILabel       *_rightPriceLabel_;
    UILabel       *_centerPriceLabel_;
    
    InnerProductDTO *leftDto_;
    InnerProductDTO *rightDto_;
    InnerProductDTO *centerDto_;
    
    UIImageView    *_leftSegmentLine;
    UIImageView    *_centerSegmentLine;
    UIImageView    *_rightSegmentLine;
}

@property (nonatomic,weak) id<Model3Delegate> imageDidDelegate;
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UILabel *centerLabel;

@property (nonatomic,strong) EGOImageViewEx *leftImageView;
@property (nonatomic,strong) EGOImageViewEx *rightImageView;
@property (nonatomic,strong) EGOImageViewEx *centerImageView;

@property (nonatomic,strong) UIImageView *leftBackImageView;
@property (nonatomic,strong) UIImageView *rightBackImageView;
@property (nonatomic,strong) UIImageView *centerBackImageView;

//@property (nonatomic,strong) UIImageView *leftBackImageViewLbl;
//@property (nonatomic,strong) UIImageView *rightBackImageViewLbl;
//@property (nonatomic,strong) UIImageView *centerBackImageViewLbl;



@property (nonatomic,strong) UILabel             *leftPriceLabel;
@property (nonatomic,strong) UILabel             *rightPriceLabel;
@property (nonatomic,strong) UILabel             *centerPriceLabel;

@property (nonatomic,strong) UILabel             *leftHintLabel;
@property (nonatomic,strong) UILabel             *centerHintLabel;
@property (nonatomic,strong) UILabel             *rightHintLabel;

@property (nonatomic,strong) EGOImageViewEx *leftPriceImageView;
@property (nonatomic,strong) EGOImageViewEx *rightPriceImageView;
@property (nonatomic,strong) EGOImageViewEx *centerPriceImageView;

@property (nonatomic,strong) InnerProductDTO     *leftDto;
@property (nonatomic,strong) InnerProductDTO     *rightDto;
@property (nonatomic,strong) InnerProductDTO     *centerDto;


@property (nonatomic,strong) SNActivityProductDTO     *leftActivityProductDto;
@property (nonatomic,strong) SNActivityProductDTO     *rightActivityProductDto;
@property (nonatomic,strong) SNActivityProductDTO     *centerActivityProductDto;

@property (nonatomic,strong) UIImageView         *leftSegmentLine;
@property (nonatomic,strong) UIImageView         *centerSegmentLine;
@property (nonatomic,strong) UIImageView         *rightSegmentLine;

- (void) setItem:(InnerProductDTO *)leftDto centerItem:(InnerProductDTO *)centerDto rightItem:(InnerProductDTO *)rightDto withTag:(NSInteger)index;

- (void)leftDto:(SNActivityProductDTO*)leftDto centerItem:(SNActivityProductDTO*)centerDto rightItem:(SNActivityProductDTO*)rightDto withTag:(NSInteger)index;//新增（3/行）


+ (CGFloat) height:(InnerProductDTO *)item;

@end
