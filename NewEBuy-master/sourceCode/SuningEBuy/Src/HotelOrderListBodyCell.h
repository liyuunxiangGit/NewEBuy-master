//
//  HotelOrderListBodyCell.h
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelOrderListDto.h"

@interface HotelOrderListBodyCell : SNUITableViewCell

@property(nonatomic,strong)HotelOrderListDto* dto;

@property(nonatomic,strong)UILabel* nameLbl;
@property(nonatomic,strong)UILabel* countLbl;
@property(nonatomic,strong)UILabel* priceLbl;

@property(nonatomic,strong)UIImageView* topLineView;

-(void)setBodyCellWithDto:(HotelOrderListDto*)dto;

+(float)nameLblHeight:(NSString*)string;

+(float)cellHeightWithDto:(HotelOrderListDto*)dto;
@end
