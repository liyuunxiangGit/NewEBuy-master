//
//  NProDetailServerCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"
#import "DataProductBasic.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@interface NProDetailServerCell : SNUITableViewCell

@property (nonatomic, strong) UILabel               *titleLbl;

@property (nonatomic, strong) OHAttributedLabel     *detailLbl;

@property (nonatomic, strong) UILabel               *tuihuoLbl;

@property (nonatomic, strong) UILabel               *zitiLbl;

@property (nonatomic, strong) UIImageView           *tuihuoImgView;

@property (nonatomic, strong) UIImageView           *zitiImgView;

@property (nonatomic, strong) UIImageView           *topLineImgView;

//选择颜色／尺码／数量
@property (nonatomic,retain)UIImageView *colorbackView;

@property (nonatomic,retain)UIButton *arrowImageV;

@property (nonatomic,retain)UILabel *colorLbl;

@property (nonatomic, strong) UIImageView   *seperateLine1;
@property (nonatomic, strong) UIImageView   *seperateLine2;

- (void)setServiceDto:(DataProductBasic *)dto coloStr:(NSString *)colorStr;

+ (CGFloat)NProDetailFourCellHeight:(DataProductBasic*)dto;
@end
