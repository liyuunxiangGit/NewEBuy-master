//
//  ReceiveInfoProductHeaderCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveInfoProductHeaderCell.h"

@implementation ReceiveInfoProductHeaderCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.shopNameLabel.frame = CGRectMake(18, 5, 180, 34);
    self.deliveryLabel.frame = CGRectMake(205, 5, 100, 34);
}

- (UILabel *)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.backgroundColor = [UIColor clearColor];
        _shopNameLabel.text = L(@"PFCollectStephenKimAston");
        _shopNameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _shopNameLabel.textColor = [UIColor light_Black_Color];
        [self.contentView addSubview:_shopNameLabel];
    }
    return _shopNameLabel;
}

- (UILabel *)deliveryLabel
{
    if (!_deliveryLabel) {
        _deliveryLabel = [[UILabel alloc] init];
        _deliveryLabel.backgroundColor = [UIColor clearColor];
        _deliveryLabel.text = [NSString stringWithFormat:@"%@：0.00",L(@"Freight")];
        _deliveryLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_deliveryLabel];
    }
    return _deliveryLabel;
}

#pragma mark ----------------------------- set item

- (void)setShopDTO:(ShopCartShopDTO *)shopDTO
{
    if (_shopDTO != shopDTO)
    {
        _shopDTO = shopDTO;
    }
    NSString *fee = [shopDTO.shipPrice stringValue];
    
    self.shopNameLabel.text = shopDTO.shopName;
    
    self.deliveryLabel.textAlignment = NSTextAlignmentRight;
    self.deliveryLabel.textColor = [UIColor grayColor];
    self.deliveryLabel.font = [UIFont boldSystemFontOfSize:13.0];
    NSRange range = [fee rangeOfString:@"￥"];
    if (range.length >0)//包含
    {
        self.deliveryLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"Freight"),fee];
        
    }
    else//不包含
    {
        self.deliveryLabel.text = [NSString stringWithFormat:@"%@：￥%0.2f",L(@"Freight"),[fee doubleValue]];
        
    }
    
}

@end
