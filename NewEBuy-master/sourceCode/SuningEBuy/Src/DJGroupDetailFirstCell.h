//
//  DJGroupDetailFirstCell.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJGroupDetailImageView.h"
#import "StrikeThroughLabel.h"
#import "OHAttributedLabel.h"
#import "DJGroupDetailDTO.h"

@interface DJGroupDetailFirstCell : UITableViewCell

@property (nonatomic, strong) DJGroupDetailImageView  *detailImageView;
@property (nonatomic, strong) UIImageView *discountImgView;
@property (nonatomic, strong) UILabel *discountLbl;
@property (nonatomic, strong) UILabel *originPrice;
@property (nonatomic, strong) StrikeThroughLabel *strikeOriginPrice;

@property (nonatomic, strong) OHAttributedLabel *savePrice;
@property (nonatomic, strong) OHAttributedLabel *savePriceLable;
@property (nonatomic, strong) OHAttributedLabel *nowPrice;
@property (nonatomic, strong) OHAttributedLabel *nowPriceLable;
@property (nonatomic, strong) OHAttributedLabel *carriagePrice;
@property (nonatomic,retain) UIImageView *pageBgImageView;

- (void)setItem:(DataProductBasic *)productDetail detailDto:(DJGroupDetailDTO *)detailDto;

@end
