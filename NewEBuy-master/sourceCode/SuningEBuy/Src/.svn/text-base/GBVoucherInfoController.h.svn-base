//
//  GBVourcherInfoController.h
//  SuningEBuy
//
//  Created by xingxuewei on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "GBVoucherDTO.h"
#import "GBVoucherSingleInfoDTO.h"
#import "GBOrderInfoDTO.h"
#import "GBVoucherSingleInfoCell.h"
#import "AllOrderDetailCommonViewController.h"

@interface GBVoucherInfoController : AllOrderDetailCommonViewController<GBVoucherSingleInfoCellDelegate>
{
    NSInteger           _voucherType;           //券类型
}

@property (nonatomic, strong)   GBVoucherDTO            *voucherDTO;                //一券多用时用到
@property (nonatomic, strong)   NSArray                 *voucherList;               //一券一用时用到
@property (nonatomic, assign)   NSInteger               voucherType;
@property (nonatomic, assign)   GBType                  tuanGouType;

@property (nonatomic,strong)    GBOrderInfoDTO          *orderDetailDto;

@property (nonatomic,strong)    UIButton                *refundBtn;

@property (nonatomic,strong)    UIButton                *allSelectBtn;

@property (nonatomic)    BOOL         isRefund;//是点击退款进入还是团购券详情进入, 1为点击退款进入

@property (nonatomic,strong) UILabel *alertLbl;
//@property (nonatomic,strong) UIImageView *alertImageV;


@end
