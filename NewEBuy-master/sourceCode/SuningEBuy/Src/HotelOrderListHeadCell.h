//
//  HotelOrderListHeadCell.h
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelOrderListDto.h"

@interface HotelOrderListHeadCell : SNUITableViewCell
@property(nonatomic,strong)HotelOrderListDto* dto;

@property(nonatomic,strong)UILabel* orderNumLbl;
@property(nonatomic,strong)UILabel* dateLbl;
//@property(nonatomic,strong)UIImageView* bottomLineView;

-(void)setHeadCellWithDto:(HotelOrderListDto*)dto;
@end
