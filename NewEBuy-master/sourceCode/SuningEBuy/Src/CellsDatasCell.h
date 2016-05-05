//
//  CellsDatasCell.h
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"
#import "DataProductBasic.h"
#import "NewOrderListDTO.h"
#import "ReturnGoodsPrepareDTO.h"
#import "ShopOrderListDto.h"
#import "ProductUtil.h"

#import "ReturnGoodsQueryDTO.h"
#import "ReturnGoodsStatusDTO.h"

#import "NewSnxpressDTO.h"
#import "ServiceDetailDTO.h"

#import "ShopDetailDto.h"

#import "GBOrderInfoDTO.h"
#import "GBCancelOrderService.h"
#import "MemberOrderNamesDTO.h"
#define KFirstBigBtnsX 90
#define KSecondBigBtnsX 216.5

#define KNewBtnsWidth 87
#define KNewSmallBtnsWidth 57

#define KNewBtnsHeight 35
#define KNewLblsHeight 13

#define KNewCellOrigionX 15


//查看物流
#define KBtnTitleColor [UIColor colorWithRGBHex:0xfc7c26]


@interface CellsDatasCell : SNUITableViewCell

@property (nonatomic, strong)NewOrderListDTO *proOrderListDto;

//商品订单数据
- (void)getProOrderListDatas:(NewOrderListDTO *)dto
                 WithIsCshop:(BOOL)isCshop;


- (void)setLblProtery:(UILabel*)lbl;
- (void)setContextLblProtery:(UILabel*)lbl;

- (float)lblNumberOfLines:(UIFont*)lblFont WithLbl:(NSString*)lblStr WithLblWidth:(float)w;

- (float)MaxlblNumberOfLines:(UIFont*)lblFont WithLbl:(NSString*)lblStr WithLblWidth:(float)w;

//判断商品名是否为多行
- (int)setProNameHeight:(NSString*)nameStr WithLbl:(UILabel*)lbl;
- (int)setNameHeight:(NSString *)nameStr WithLbl:(UILabel *)lbl;


@end
