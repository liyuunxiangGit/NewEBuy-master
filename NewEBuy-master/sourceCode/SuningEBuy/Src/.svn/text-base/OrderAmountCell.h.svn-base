//
//  OrderAmountCell.h
//  SuningEBuy
//
//  Created by Yang on 14-7-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberOrderDetailsDTO.h"
#import "MemberOrderNamesDTO.h"
@interface OrderAmountCell : UITableViewCell

//订单金额块
@property (nonatomic, strong) UILabel *orderSum;//订单金额
@property (nonatomic, strong) UILabel *orderSumPrice;//订单金额价格
@property (nonatomic, strong) UILabel *productSum;//商品金额
@property (nonatomic, strong) UILabel *productSumPrice;//商品金额价格
@property (nonatomic, strong) UILabel *privilegeSum;//优惠金额
@property (nonatomic, strong) UILabel *privilegeSumPrice;//优惠金额价格
@property (nonatomic, strong) UILabel *freightSum;//运费金额
@property (nonatomic, strong) UILabel *freightSumPrice;//运费金额价格
@property (nonatomic, strong) UIImageView *line;

//合约机套餐信息
@property (nonatomic, strong) UILabel *phoneNumber;//手机号码标题
@property (nonatomic, strong) UILabel *phoneNumberContent;//手机号码
@property (nonatomic, strong) UILabel *packageInformation;//套餐信息标题
@property (nonatomic, strong) UILabel *packageInformationContent;//套餐信息
//订单金额行设置
- (void)setOrderAmountCell:(MemberOrderDetailsDTO *)detailDto
               WithNameDto:(MemberOrderNamesDTO *)nameDto
       WithSectionPosition:(int)section
          WithCellPosition:(int)row;

//合约机套餐信息
- (void)setSimCardInfo:(MemberOrderDetailsDTO *)detailDto;

@end
