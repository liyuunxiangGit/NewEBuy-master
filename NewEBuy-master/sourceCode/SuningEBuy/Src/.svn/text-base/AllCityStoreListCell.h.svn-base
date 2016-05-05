//
//  NearbySuningShopListCell.h
//  SuningEBuy
//
//  Created by JackyWu on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuningStoreDTO.h"

//@protocol AllCityStoreListCellDelegate <NSObject>
//
//- (void)changeCollectOrNot:(UIButton *)btn;
//
//@end

@interface AllCityStoreListCell : UITableViewCell

@property (nonatomic, strong) UILabel               *shopNameLbl;

@property (nonatomic, strong) UILabel               *addressLbl;

@property (nonatomic, strong) UILabel               *distanceLbl;

//@property (nonatomic, strong) UIButton              *collectBtn;
@property (nonatomic, strong) UIImageView           *collectHeart;

@property (nonatomic, strong) SuningStoreDTO        *allCitySuningDto;

@property (nonatomic, strong) UIImageView           *positionImage;

@property (nonatomic, strong) UIImageView           *backView;

//@property (nonatomic, weak) id<AllCityStoreListCellDelegate> delegate;

- (void)setItem:(SuningStoreDTO *)dto;

+ (CGFloat)heightOfCell:(SuningStoreDTO *)dto;

@end

