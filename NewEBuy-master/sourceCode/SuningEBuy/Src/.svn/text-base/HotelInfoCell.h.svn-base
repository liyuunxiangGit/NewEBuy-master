//
//  HotelInfoCell.h
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelStarView.h"

#import "HotelOrderDetailDTO.h"
@interface HotelInfoCell : SNUITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) HotelStarView *starView;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *roomType;

@property (nonatomic, strong) UILabel *typeLbl;

@property (nonatomic, strong) UILabel *roomNum;

@property (nonatomic, strong) UILabel *numLbl;

@property (nonatomic, strong) UILabel *roomTime;

@property (nonatomic, strong) UILabel *timeLbl;

@property(nonatomic,strong)HotelOrderDetailDTO* dto;

@property(nonatomic,strong)UIImageView* starLineView;

@property(nonatomic,strong)UIImageView* addressLineView;

+(float)cellHeightWithDto:(HotelOrderDetailDTO*)dto;
+(float)addressLabelHeightWithString:(NSString*)string;
+(float)nameLabelHeightWithString:(NSString*)string;


-(void)setHotelInfoCellWithDto:(HotelOrderDetailDTO*)dto;
@end
