//
//  NewHotelIntroduceTitelCell.h
//  SuningEBuy
//
//  Created by Qin on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//酒店简介头View
#import <UIKit/UIKit.h>
#import "HotelStarView.h"
#import "HotelIntroduceDTO.h"

@interface NewHotelIntroduceTitelCell : UITableViewCell
@property (nonatomic, strong)EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) HotelStarView *starView;

@property (nonatomic, strong) HotelIntroduceDTO * hotelDto;
@property (nonatomic, strong) UIImageView* lineImageView;


+(float)cellHeightWithDto:(HotelIntroduceDTO*)dto;
+(float)addressLabelHeightWithString:(NSString*)string;
+(float)nameLabelHeightWithString:(NSString*)string;

-(void)setCellWithDto:(HotelIntroduceDTO*)dto;
@end
