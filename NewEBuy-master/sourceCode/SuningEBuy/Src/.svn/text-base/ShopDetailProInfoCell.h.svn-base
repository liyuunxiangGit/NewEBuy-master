//
//  ShopDetailProInfoCell.h
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailDto.h"


@interface ShopDetailProInfoCell : UITableViewCell

@property (nonatomic,retain) EGOImageView *productImageV;//商品图片
@property (nonatomic,retain) UILabel *productNameLbl;//商品名

@property (nonatomic,retain) UILabel *shopContextLbl;//商家
@property (nonatomic,retain) UILabel *productPriceContextLbl;//商品价格
@property (nonatomic,retain) UILabel *yangLbl;//¥

@property (nonatomic,retain) UILabel *productNumLbl;//商品数量
@property (nonatomic,retain) UILabel *productNumContextLbl;

@property (nonatomic,retain) UIImageView *lineView;

@property (nonatomic,retain) NSString *supplierStr;

@property (nonatomic,retain) UILabel *orderStatusContextLbl;//订单状态

@property (nonatomic,retain) UIButton *snxpressQueryBtn;//物流查询按钮

//detail
@property (nonatomic,retain) UIButton *pingJiaBtn;//评价按钮
@property (nonatomic,retain) UIButton *shaiDanBtn;//晒单按钮

@property (nonatomic,retain) UIImageView *lineTwoView;

//@property (nonatomic,retain) MemberOrderNamesDTO *listDetailDto;
//@property (nonatomic,retain) MemberOrderDetailsDTO *detailDto;
@property(nonatomic,strong)     UIImageView     *accessView;        //小箭头
@property(nonatomic,strong)     UIImageView     *lineView2;         //分割线2

//订单详情界面设置
- (void)setShopDetailProInfoCellInfo:(ShopDetailDto*)dto
                         WithHeadDto:(ShopDetailItemDto *)itemDto
                        WithPosition:(NSInteger)cellRow;
                        
+ (CGFloat)setShopDetailProInfoCellHeight:(ShopDetailDto*)dto;


@end
