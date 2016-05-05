//
//  OrderDetailCell.h
//  SuningEBuy
//
//  Created by xmy on 7/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"
#import "MemberOrderDetailsDTO.h"
#import "MemberOrderNamesDTO.h"

#import "ShopDetailDto.h"
//#import "keyboardNumberPadReturnTextField.h"
//#import "PlaceholderTextView.h"

@interface OrderDetailCell : CellsDatasCell

@property(nonatomic,strong) UILabel      *personNameLbl;//收货人
@property(nonatomic,strong) UILabel      *mobileLbl;//手机号
@property(nonatomic,strong) UILabel      *adressLbl;//收货人地址
@property (nonatomic,retain) UIImageView *lineView;


//商品订单详情
- (void)setOrderDetailCellInfo:(MemberOrderDetailsDTO*)detailDto
                   WithNameDto:(MemberOrderNamesDTO*)nameDto;

+ (CGFloat)setOrderDetailCellHeight:(MemberOrderDetailsDTO*)detailDto;

//门店订单
- (void)setShopDetailHeadCellInfo:(ShopDetailDto*)detailDto;

+ (CGFloat)setShopOrderDetailCellHeight:(ShopDetailDto*)detailDto;

@end


@interface OrderDetailWayCell : CellsDatasCell<UITextFieldDelegate>

@property(nonatomic,strong) UILabel      *wayLbl;//支付（送货）方式
@property(nonatomic,strong) UILabel      *wayContextLbl;
@property(nonatomic,strong) UIImageView  *ercordImg; //add by gjf 二维码
@property (nonatomic,retain) UIImageView *lineView;
@property(nonatomic,strong) UIImageView     *accessView;        //小箭头
@property (nonatomic,retain) UIImageView *numLineView;

@property(nonatomic,strong)UITextField *refundAccountTF;
@property(nonatomic,strong)ReFundInfoDto   *refundInfo;
@property (nonatomic,weak)id myDelegate;
@property(nonatomic,strong)UILabel *refundAccountLbl;

//发票块
@property (nonatomic, strong) UILabel *moreInvoiceInfo;//更多电子发票信息


- (void)setOrderDetailWayCellInfo:(MemberOrderDetailsDTO *)detailDto
                      WithNameDto:(MemberOrderNamesDTO *)nameDto
              WithSectionPosition:(int)section
                 WithCellPosition:(int)row;

+ (CGFloat)setOrderDetailWayCellHeight:(MemberOrderDetailsDTO*)detailDto;

// 门店订单
- (void)setShopDetailHeadCellInfo:(ShopDetailDto*)detailDto
                      WithItemDto:(ShopDetailItemDto*)nameDto
              WithSectionPosition:(int)section
                 WithCellPosition:(int)row;

//生活团购订单详情
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto
          WithSectionPosition:(int)section
               WithCellPosition:(int)row
                       WithRows:(int)num;
//+ (CGFloat)setGroupOrderDetailCellHeight:(GBOrderInfoDTO *)dto
//            WithSectionPosition:(int)section
//               WithCellPosition:(int)row;
+ (NSInteger)setRowsOfSection:(GBOrderInfoDTO *)dto;
//生活团购退款
- (void)setGroupRefundDetailCell:(ReFundInfoDto *)dto
            WithSectionPosition:(int)section
               WithCellPosition:(int)row;
@end
