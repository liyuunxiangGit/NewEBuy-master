//
//  NOrderHeadCell.h
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewOrderListDTO.h"

@interface NOrderHeadCell : UITableViewCell

@property(nonatomic,strong) UIImageView  *backView;
@property(nonatomic,strong) UILabel      *orderIdLbl;
@property(nonatomic,strong) UILabel      *updateTimeLbl;
@property(nonatomic,strong) UILabel      *totoaPriceLbl;
@property(nonatomic,strong) UILabel      *priceLbl;
@property(nonatomic,strong)     UIButton        *payBtn;            //支付按钮
@property(nonatomic,strong)     UIButton        *cancelOrderBtn;    //取消订单按钮

@property (nonatomic,strong) NewOrderListDTO *item;
-(void)refreshCell:(NewOrderListDTO *)dto WithIsCshop:(BOOL)isCshop;

@end
