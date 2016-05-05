//
//  GBGoodsDetailForthCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsDetailForthCell.h"

@implementation GBGoodsDetailForthCell

@synthesize topBtn                          = _topBtn;
@synthesize bottomBtn                       = _bottomBtn;
@synthesize centerBtn                       = _centerBtn;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_centerBtn);
    TT_RELEASE_SAFELY(_bottomBtn);
    TT_RELEASE_SAFELY(_topBtn);
 
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)goodsType:(NSString *)type
{
    if ([type isEqualToString:@"1"]) {
        [self.topBtn setTitle:L(@"GBProjectOfGroupBuy") forState:UIControlStateNormal];
        [self.centerBtn setTitle:L(@"GB_Shop_Info") forState:UIControlStateNormal];
        [self.topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -145, 0, 0)];

        self.topBtn.frame = CGRectMake(10, 0, 300, 50);
        self.centerBtn.frame = CGRectMake(10, 50, 300, 50);

    }else{
        [self.topBtn setTitle:L(@"GB_Goods_Detail") forState:UIControlStateNormal];
        [self.centerBtn setTitle:L(@"GB_Shop_Info") forState:UIControlStateNormal];
        [self.topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -180, 0, 0)];
        
        self.topBtn.frame = CGRectMake(10, 0, 300, 50);
        self.centerBtn.frame = CGRectMake(10, 50, 300, 50);
    }
}

- (UIButton *)topBtn
{
    if (!_topBtn)
    {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.tag = 1001;
        [_topBtn setBackgroundImage:[UIImage imageNamed:@"GB_cell_top_background.png"] forState:UIControlStateNormal];
        _topBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [_topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _topBtn.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.frame = CGRectMake(270, 20, 10, 15);
        [_topBtn addSubview:imageV];
        [self.contentView addSubview:_topBtn];
    }
    return _topBtn;
}

- (UIButton *)centerBtn
{
    if (!_centerBtn)
    {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.tag = 1002;
        _centerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [_centerBtn setBackgroundImage:[UIImage imageNamed:@"GB_cell_bottom_background.png"] forState:UIControlStateNormal];
        [_centerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -180, 0, 0)];
        [_centerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _centerBtn.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.frame = CGRectMake(270, 20, 10, 15);
        [_centerBtn addSubview:imageV];
        [self.contentView addSubview:_centerBtn];
    }
    return _centerBtn;
}


@end