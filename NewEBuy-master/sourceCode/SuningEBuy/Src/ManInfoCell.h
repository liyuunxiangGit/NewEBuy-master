//
//  ManInfoCell.h
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelOrderDetailDTO.h"

@interface ManInfoCell : SNUITableViewCell

@property(nonatomic,strong)HotelOrderDetailDTO* dto;

@property (nonatomic, strong) UILabel *liveMan;

@property (nonatomic, strong) UILabel *contactMan;

@property (nonatomic, strong) UILabel *erliestCome;

@property (nonatomic, strong) UILabel *latestCome;

@property (nonatomic, strong) UILabel *liveNamesLbl;

@property (nonatomic, strong) UILabel *contactLbl;

@property (nonatomic, strong) UILabel *erliestLbl;

@property (nonatomic, strong) UILabel *latestLbl;

@property(nonatomic,strong)UIImageView* liveManLine;

@property(nonatomic,strong)UIImageView* contactManLine;

-(void)setManInfoCellWithDto:(HotelOrderDetailDTO*)dto;
@end
