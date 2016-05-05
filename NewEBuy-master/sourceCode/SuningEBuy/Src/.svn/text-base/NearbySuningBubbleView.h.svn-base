//
//  NearbySuningBubbleView.h
//  SuningEBuy
//
//  Created by cui zl on 13-3-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NearbySuningDTO.h"
//#import "StoreListDTO.h"
#import "SuningStoreDTO.h"

@interface NearbySuningBubbleView : UIView
{
    SNBasicBlock  gotoDetailBlock;
}

@property (nonatomic, strong) UILabel           *titleLbl;
@property (nonatomic, strong) UILabel           *detailLbl;
@property (nonatomic, strong) UIButton          *detailBtn;
@property (nonatomic, strong) UIImageView       *leftImg;
@property (nonatomic, strong) UILabel           *distanceLabel;

@property (nonatomic, strong) UIImageView       *arrowImg;
//@property (nonatomic, strong) StoreListDTO      *nearbySuningDto;

@property (nonatomic, strong) SuningStoreDTO      *nearbySuningDto;


-(void)setGoToDetailBlock:(SNBasicBlock)block;

- (BOOL)showFromRect:(CGRect)rect;

@end
