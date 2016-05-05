//
//  GBWWOrderDetailCell.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBOrderInfoDTO.h"

@interface GBOrderDetailInfoCell : UITableViewCell
{
    GBOrderInfoDTO *_item;
    
    NSMutableArray *orderStateList;
    
}
//订单信息
@property (nonatomic, strong) UILabel *orderInfoContentLbl;


@property (nonatomic ,strong) UILabel *orderNumberLbl;


@property (nonatomic ,strong) UILabel *orderTimeLbl;


@property (nonatomic,strong)UIButton *orderNameLbl;


@property (nonatomic ,strong) UILabel *numLbl;


@property (nonatomic, strong) UILabel *priceLbl;


@property (nonatomic, strong)UILabel *phoneLabel;


@property (nonatomic,strong) UILabel *orderStateLbl;

@property(nonatomic, copy)GBOrderInfoDTO *item;

@property(nonatomic,weak)id myDelegate;

@property (nonatomic,strong)UIImageView *btnImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+(CGFloat)height:(GBOrderInfoDTO *)item;

- (void)setItem:(GBOrderInfoDTO *)item;


@end
