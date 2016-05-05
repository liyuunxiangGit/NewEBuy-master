//
//  ReturnGoodSDetailCell.h
//  SuningEBuy
//
//  Created by Yang on 14-7-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnGoodsPrepareDTO.h"
@interface ReturnGoodSDetailCell : UITableViewCell


@property (nonatomic, strong) UILabel              *generalLabelOne;//通用Label1
@property (nonatomic, strong) UILabel              *generalLabelTwo;//通用Label2
@property (nonatomic, strong) UIImageView          *lineView;
@property (nonatomic, strong) UITextField          *addressTextField;//详细地址

- (void)setBackTypeContent:(ReturnGoodsPrepareDTO *)returnDto;//配送商品返回方式
- (void)setGoShopBackTypeContent:(ReturnGoodsPrepareDTO *)returnDt;//自提商品返回方式
- (void)setGoShopTakeAddress:(ReturnGoodsPrepareDTO *)returnDto shopAddress:(NSString *)address;//自提商品门店地址

- (void)setTakeAddress:(ReturnGoodsPrepareDTO *)returnDto;//取件地址
- (void)setPersonName:(ReturnGoodsPrepareDTO *)returnDto;//联系人
- (void)setPersonPhoneNumber:(ReturnGoodsPrepareDTO *)returnDto;//手机号码
- (void)setTakeTime:(ReturnGoodsPrepareDTO *)returnDto;//取件时间
- (void)setReturnNumber:(ReturnGoodsPrepareDTO *)returnDto;//退货数量
- (void)setInvoice:(ReturnGoodsPrepareDTO *)returnDto taxType:(NSString *)taxType;//发票

@end
