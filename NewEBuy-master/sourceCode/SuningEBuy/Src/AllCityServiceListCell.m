//
//  AllCityServiceListCell.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityServiceListCell.h"

@implementation AllCityServiceListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
}

- (void)setItem:(StoreServiceDTO *)dto
{
    
    self.imgView.imageURL = [NSURL URLWithString:dto.logoUrl];
        
    self.serviceLbl.text = dto.serviceName;
        
    self.contentLbl.text = dto.serveDescription;
    
}

- (SNUIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[SNUIImageView alloc] init];
        
        _imgView.userInteractionEnabled = NO;
        
        [self.contentView addSubview:_imgView];
    }
    
    return _imgView;
}

- (SNUIImageView *)arrowView
{
    if (!_arrowView)
    {
        _arrowView = [[SNUIImageView alloc] init];
        
        _arrowView.userInteractionEnabled = NO;
        
        _arrowView.image = [UIImage imageNamed:@"suning_icon_more.png"];
        
        [self.contentView addSubview:_arrowView];
    }
    
    return _arrowView;
}

- (UIImageView *)topView
{
    if (!_topView)
    {
        _topView = [[UIImageView alloc]init];
        
        _topView.image = [UIImage imageNamed:@"suning_list_top.png"];
        
        [self.contentView addSubview:_topView];
    }
    
    return _topView;
}

- (UIImageView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIImageView alloc]init];
        
        _bottomView.image = [UIImage imageNamed:@"suning_list_bottom.png"];
        
        [self.contentView addSubview:_bottomView];
    }
    
    return _bottomView;
}

- (UIImageView *)centerView
{
    if (!_centerView)
    {
        _centerView = [[UIImageView alloc]init];
        
        _centerView.image = [UIImage imageNamed:@"suning_list_center.png"];
        
        [self.contentView addSubview:_centerView];
    }
    
    return _centerView;
}

- (UIImageView *)line
{
    if (!_line)
    {
        _line = [[UIImageView alloc]init];
        
        _line.backgroundColor = [UIColor clearColor];
        
        _line.image = [UIImage streImageNamed:@"line"];
        
        [self.contentView addSubview:_line];
    }
    return _line;
}

- (UILabel *)serviceLbl
{
    if (!_serviceLbl)
    {
        _serviceLbl = [[UILabel alloc] init];
        
        _serviceLbl.font = [UIFont boldSystemFontOfSize:14];
        
        _serviceLbl.backgroundColor = [UIColor clearColor];
        
        _serviceLbl.numberOfLines = 1;
        
        _serviceLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _serviceLbl.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_serviceLbl];
        
    }
    return _serviceLbl;
}

- (UILabel *)contentLbl
{
    if (!_contentLbl)
    {
        _contentLbl = [[UILabel alloc] init];
        
        _contentLbl.font = [UIFont systemFontOfSize:13];
        
        _contentLbl.backgroundColor = [UIColor clearColor];
        
        _contentLbl.numberOfLines = 0;
        
        _contentLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        
        _contentLbl.textAlignment = UITextAlignmentLeft;
        
        _contentLbl.numberOfLines = 2;
        
        [self.contentView addSubview:_contentLbl];
        
    }
    return _contentLbl;
}

@end
