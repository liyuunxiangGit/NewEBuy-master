//
//  ShopOrderItemCell.h
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopOrderListDto.h"
#import "AppConstant.h"



@interface ShopOrderItemCell : UITableViewCell

@property(nonatomic,strong)     UIImageView     *backView;          //背景图片
@property(nonatomic,strong)     EGOImageButton    *iconImageView;     //商品图片
@property(nonatomic,strong)     UILabel         *productNameLbl;    //商品名称
@property(nonatomic,strong)     UILabel         *supplierLbl;       //供应商名称
@property(nonatomic,strong)     UILabel         *priceLbl;          //价格
@property(nonatomic,strong)     UILabel         *productNumLbl;     //商品数量
@property(nonatomic,strong)     UIImageView     *lineView1;         //分割线1
@property(nonatomic,strong)     UIImageView     *accessView;        //小箭头
@property(nonatomic,strong)     UILabel         *orderStatusLbl;    //订单状态
@property(nonatomic,strong)     UIButton        *snxpressQueryBtn;  //物流查询按钮
//@property(nonatomic,strong)     UIButton        *payBtn;            //支付按钮
//@property(nonatomic,strong)     UIButton        *cancelOrderBtn;    //取消订单按钮
@property(nonatomic,strong)     UIImageView     *lineView2;         //分割线2


-(void)refreshCell:(ShopOrderItemListDto *)productDto
          orderDto:(ShopOrderListDto *)orderDto
          cellType:(CellViewType)cellType;
@end
