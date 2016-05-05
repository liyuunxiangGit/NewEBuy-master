//
//  NProDetailThirdCell.h
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "DataProductBasic.h"

@interface NProDetailThirdCell : UITableViewCell

@property (nonatomic,retain)UILabel *eGoPrice;//易购价

@property (nonatomic,retain)StrikeThroughLabel *eGoPriceLbl;

@property (nonatomic,retain)UILabel *downPrice;//直降价

@property (nonatomic,retain)StrikeThroughLabel *downPriceLbl;

@property (nonatomic,retain)UILabel *activetyLbl;//促销活动

@property (nonatomic,retain)UILabel *activetyTitleLbl;

@property (nonatomic,retain)UIImageView *activetyImageView;

@property (nonatomic,retain)UILabel *sellPointLab;

@property (nonatomic, strong) UIImageView *linImgView;

@property (nonatomic)NSInteger type;  //1,普通 2，抢购

@property (nonatomic, retain)DataProductBasic *nDto;

- (void)setNProDetailThirdCellInfo:(DataProductBasic*)dto;

+ (CGFloat)NProDetailThirdCellHeight:(DataProductBasic*)dto;

@end
