//
//  OrderSubmitHeadCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-14.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"

@interface OrderSubmitHeadCell : UITableViewCellEx


@property(nonatomic,strong)  UILabel     *goodsTotalLbl;

@property(nonatomic,strong)  UILabel     *priceAmountLbl;

@property(nonatomic,copy)    NSString    *priceAmount;


- (void)setPriceAmount:(NSString *)priceAmount;

@end
