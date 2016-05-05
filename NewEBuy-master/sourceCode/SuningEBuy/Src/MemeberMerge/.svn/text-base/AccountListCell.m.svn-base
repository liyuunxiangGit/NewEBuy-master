//
//  AccountListCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccountListCell.h"

@implementation AccountListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setItem:(CardNoListDTO *)item
{
    _item = item;
    
    [self.contentView addSubview:self.cardName];

    self.cardName.text = [NSString stringWithFormat:@"%@:%@",_item.ecoType,_item.cardNo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.cardName.frame = CGRectMake(15, 0, 260, 40);
}


- (UILabel *)cardName
{
    if (!_cardName) {
        _cardName = [[UILabel alloc] init];
        _cardName.backgroundColor = [UIColor clearColor];
        _cardName.textColor = [UIColor light_Black_Color];
        _cardName.font = [UIFont boldSystemFontOfSize:15.0];
        _cardName.text = L(@"UCElectricCard");
        [self.contentView addSubview:_cardName];
    }
    return _cardName;
}

@end
