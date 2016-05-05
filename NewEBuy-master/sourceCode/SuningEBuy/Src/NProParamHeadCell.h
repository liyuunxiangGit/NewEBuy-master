//
//  NProParamHeadCell.h
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

@interface NProParamHeadCell : UITableViewCell

@property (nonatomic, strong) UILabel *infoLbl;

@property (nonatomic, retain)UIImageView *arrowImageView;

@property (nonatomic, retain)UIImageView *backImageView;

@property (nonatomic, retain)UIImageView *lineImageView;
@property (nonatomic, retain)UIImageView *bottomLine;

@property (nonatomic, retain)UIButton *arrowBtn;


- (void)setNProParamHeadCellInfo:(DataProductBasic*)dto WithBool:(BOOL)isFold WithPosition:(NSInteger)row;


@end
