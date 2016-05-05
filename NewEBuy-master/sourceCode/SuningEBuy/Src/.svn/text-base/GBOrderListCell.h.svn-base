//
//  GBOrderListCell.h
//  SuningEBuy
//
//  Created by xingxuewei on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCellEx.h"

#import "GBOrderInfoDTO.h"
#define  ORDER_LIST_CELL_HEIGHT  120


@interface GBOrderListCell : UITableViewCellEx
{
    GBOrderInfoDTO *_item;
}
@property (nonatomic, strong)   UILabel         *nameLbl;

@property (nonatomic, strong)   UILabel         *numberContentLbl;
@property (nonatomic, strong)   UILabel         *numberLbl;

@property (nonatomic, strong)   UILabel         *orderStateContentLbl;
@property (nonatomic, strong)   UILabel         *orderStateLbl;

@property (nonatomic, strong)   UILabel         *priceLbl;

@property (nonatomic, strong)  UIImageView *image;

@property (nonatomic, strong) GBOrderInfoDTO *item;

@property (nonatomic,strong) NSArray *orderStateList;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+(CGFloat) height:(GBOrderInfoDTO *)item;
- (void)setItem:(GBOrderInfoDTO *)item;
@end
