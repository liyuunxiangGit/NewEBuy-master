//
//  ReturnGoodsSubmitInfoCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReturnGoodsPrepareDTO.h"
//退货申请，提交
@interface ReturnGoodsSubmitInfoCell : UITableViewCell

@property (nonatomic, strong)  UILabel                     *productNameLbl;        //商品名称 

@property (nonatomic, strong)  UILabel                     *orderNumLbl;           //订单号 
@property (nonatomic, strong)  UILabel                     *payTypeLbl;            //支付方式
@property (nonatomic, strong)  UILabel                     *productNoLbl;          //商品数量

@property (nonatomic, strong)  UILabel                     *saleChannelLbl;        //销售渠道

@property (nonatomic, strong)  UILabel                     *productPriceLbl;        //销售渠道
@property (nonatomic, strong) UIButton *connectButton; //和我联系按钮
@property (nonatomic, strong) UIButton *phoneButton  ; // 电话按钮
@property (nonatomic, strong)  UIImageView *lineView;// line
@property (nonatomic, strong)  UIImageView *lineView2;// line竖

- (void)setItem:(ReturnGoodsPrepareDTO *)prepareDto status:(int)status;
@end
