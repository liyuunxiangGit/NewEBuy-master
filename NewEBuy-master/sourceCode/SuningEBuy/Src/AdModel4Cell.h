//
//  AdModel4Cell.h
//  SuningEBuy
//
//  Created by xmy on 18/7/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCellEx.h"
#import "InnerProductDTO.h"
#import "DataProductBasic.h"

@class AdModel4Cell;

@protocol Model4Delegate <NSObject>

- (void)cellImageDidClicked:(DataProductBasic *)dto;

@end

@interface AdModel4Cell : UITableViewCellEx<EGOImageViewExDelegate>
{
    
    EGOImageViewEx *innerAdImageView_;

}

@property (nonatomic,weak) id<Model4Delegate> imageDidDelegate;

@property (nonatomic,strong) EGOImageViewEx *innerAdimageView;
@property (nonatomic,strong) UIImageView *salesSmallImage;
@property (nonatomic,strong) UILabel *salesBigBangNameLbl;


@property (nonatomic,strong) InnerProductDTO *innerDto;
@property (nonatomic,strong) UILabel *productNameLbl;
@property (nonatomic,strong) UILabel *priceLbl;
@property (nonatomic,strong) UILabel *yiGouLbl;
@property (nonatomic,strong) UIImageView *bigBackImageView;

@property (nonatomic,strong) EGOImageViewEx *priceImageView;
@property (nonatomic,strong) UILabel *priceHintLabel;

- (void)setItem:(InnerProductDTO *)ainnerDto withTag:(NSInteger)index;


@end
