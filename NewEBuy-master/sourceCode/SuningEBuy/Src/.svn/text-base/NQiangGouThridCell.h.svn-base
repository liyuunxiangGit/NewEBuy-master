//
//  NQiangGouThridCell.h
//  SuningEBuy
//
//  Created by xmy on 26/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "PanicPurchaseDTO.h"
#import "DataProductBasic.h"
#import "DJGroupDetailDTO.h"
#import "BigSaleDTO.h"
#import "AppointmentDTO.h"

typedef enum : NSUInteger {
    QianggouPrice       = 0,    //抢购
    TuangouPrice        = 1,    //团购
    DajuhuiPrice        = 2,    //大聚惠
    AppointmentPrice    = 3,    //预约
} SpecialPriceState;

@interface NQiangGouThridCell : UITableViewCell
{
    BOOL _isQiangOrTuan;//是否有抢购或团购
}

@property (nonatomic,retain)UIImageView         *backView;//背景图片

@property (nonatomic,retain)UILabel             *eGoPrice;//易购价

@property (nonatomic,retain)StrikeThroughLabel  *eGoPriceLbl;

@property (nonatomic,retain)UILabel             *downPrice;//直降价

@property (nonatomic,retain)StrikeThroughLabel  *downPriceLbl;

@property (nonatomic,retain)UILabel             *saveLbl;//数量

@property (nonatomic,retain)UILabel             *activetyLbl;//促销标签

@property (nonatomic,retain)UIImageView         *activetyImageView;

@property (nonatomic,retain)UILabel             *sellPointLab;

@property (nonatomic, strong) UIImageView       *seperateLine;

@property (nonatomic, strong) BigSaleDTO        *bigSaleDto;

@property (nonatomic, strong) AppointmentDTO    *appointmentDto;

//团购cell设置
- (void)setNQiangGouThridCellInfo:(PanicPurchaseDTO*)qiangGouDto WithDetail:(DataProductBasic *)dto;

//抢购cell设置
- (void)setNTuanGouThridCellInfo:(DJGroupDetailDTO*)tuanGoudto WithDetail:(DataProductBasic *)dto;

//大聚惠cell设置
- (void)setBigSaleThirdCellInfo:(BigSaleDTO *)bigSaleDto WithDetail:(DataProductBasic *)dto;

//预约cell设置
- (void)setAppointmentThirdCellInfo:(AppointmentDTO *)appointmentDto WithDetail:(DataProductBasic *)dto;

+ (CGFloat)NSpecialThirdCellHeight:(DataProductBasic *)dto withType:(ProductDeatailType)type;

@end
