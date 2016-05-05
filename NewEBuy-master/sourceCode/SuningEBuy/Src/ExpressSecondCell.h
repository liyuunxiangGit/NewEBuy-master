//
//  ExpressSecondCell.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnGoodsQueryDTO.h"

@interface ExpressSecondCell : UITableViewCell
@property (nonatomic, strong)  UILabel  *returnGoodsAddress;  //退货地址
@property (nonatomic, strong)  UILabel  *connectType;         //联系方式
@property (nonatomic, strong)  UILabel  *consignee ;          //收货人

@property (nonatomic, strong)  UIImageView *lineView;// line
@property (nonatomic, strong)  UILabel  *remark ;




+ (CGFloat)height:(ReturnGoodsQueryDTO *)prepareDto;

- (void)setItem:(ReturnGoodsQueryDTO *)prepareDto;

@end
