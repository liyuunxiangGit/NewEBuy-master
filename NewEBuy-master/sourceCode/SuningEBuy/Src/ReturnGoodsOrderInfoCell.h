//
//  ReturnGoodsOrderInfoCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellsDatasCell.h"
#import "ReturnGoodsQueryDTO.h"
//退货查询cell
@interface ReturnGoodsOrderInfoCell : CellsDatasCell
{
    
    UILabel                     *_productName;

    UILabel                     *_orderNum;
    
    UILabel                     *_productPayTime;

    UILabel                     *_serviceType;
    
    ReturnGoodsQueryDTO         *_item;

}


@property (nonatomic, strong)  UILabel             *productName;

@property (nonatomic, strong)  UILabel             *orderNum;

@property (nonatomic, strong)  UILabel             *productPayTime;

@property (nonatomic, strong)  UILabel             *serviceType;

@property (nonatomic, strong)  ReturnGoodsQueryDTO         *item;
@property (nonatomic, strong)  UIButton            *shopConnect;//和我联系
@property (nonatomic, strong)  UIButton            *cShopConnect;//和我联系
@property (nonatomic, strong)  UIImageView         *lineView;// line
@property (nonatomic, strong)  UIImageView *       lineView2;// line竖
@property (nonatomic, strong)  UIButton            *Phone;//电话按钮
@property (nonatomic, strong)  UIView              *connectView1;
@property (nonatomic, strong)  UIView              *connectView2;


@property(nonatomic,strong)     EGOImageButton    *iconImageView;     //商品图片
@property(nonatomic,strong)     UILabel         *productNameLbl;    //商品名称
@property(nonatomic,strong)     UILabel         *supplierLbl;       //供应商名称

- (void)setItem:(ReturnGoodsQueryDTO *)item status:(int)status;
+ (CGFloat)height:(ReturnGoodsQueryDTO *)item status:(int)status;

//新界面
- (void)setNewItem:(ReturnGoodsQueryDTO *)item status:(int)status;
+ (CGFloat)heightNewCell:(ReturnGoodsQueryDTO *)item status:(int)status;


@end
