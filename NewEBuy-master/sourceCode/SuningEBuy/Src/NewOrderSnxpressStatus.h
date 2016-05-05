//
//  NewOrderSnxpressStatus.h
//  SuningEBuy
//
//  Created by xmy on 2/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CalculateLblHeightCell.h"
#import "NewSnxpressDTO.h"


typedef enum{
    CellType1,
    CellType2,
} HeadCellType;

@interface NewOrderSnxpressStatus : CalculateLblHeightCell

@property (nonatomic, strong) UILabel        *desLbl;           //声明
@property (nonatomic, strong) UILabel        *packageNameLbl;   //包裹名称
@property (nonatomic, strong) UILabel        *statusLabel;      //送货详情
@property (nonatomic, strong) UILabel        *deliveryLabel;    //预计送达时间
@property (nonatomic, strong) UIImageView    *lineView;         //分界线

-(void)refreshCell:(NewSnxpressDTO *)dto cellType:(HeadCellType)cellType;

@end
