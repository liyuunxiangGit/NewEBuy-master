//
//  ReceiveInfoProductHeaderCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"
#import "ShopCartShopDTO.h"

@interface ReceiveInfoProductHeaderCell : SNUITableViewCell

@property (nonatomic, retain) UILabel           *shopNameLabel; //供应商名称
@property (nonatomic, strong) ShopCartShopDTO   *shopDTO;       //供应商数据
@property (nonatomic, retain) UILabel           *deliveryLabel; //运费

@end
