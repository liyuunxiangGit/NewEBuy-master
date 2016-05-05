//
//  AllCityCampaignCell.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityCampaignListCell.h"

@implementation AllCityCampaignListCell

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
    
    _imgView.frame = CGRectMake(20, self.height/2-42.5, 110, 75);
    
    _label.frame = CGRectMake(142, 28, 160, self.height - 50);
    
    _campaignNameLbl.frame = CGRectMake(142, self.height/2-42.5, 160, 20);
    
    _topView.frame = CGRectMake(10, 0, 300, 1);
    
    _bottomView.frame = CGRectMake(10, self.height - 13, 300, 3);
    
    _centerView.frame = CGRectMake(10, 1, 300, self.height - 13);
    
}

- (void)setItem:(StoreCampaignDTO *)dto
{
    
    self.centerView.image = [UIImage imageNamed:@"suning_list_center.png"];
    
    self.imgView.imageURL = [NSURL URLWithString:dto.detailPic];
    
    self.label.text = dto.campDescription;
    
    self.campaignNameLbl.text = dto.name;
    
    self.topView.image = [UIImage imageNamed:@"suning_list_top.png"];
    
    self.bottomView.image = [UIImage imageNamed:@"suning_list_bottom.png"];
    
}

- (UIImageView *)topView
{
    if (!_topView)
    {
        _topView = [[UIImageView alloc]init];
        
        _topView.frame = CGRectMake(10, 0, 300, 1);
        
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

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        
        _label.font = [UIFont systemFontOfSize:13];
        
        _label.backgroundColor = [UIColor clearColor];
        
        _label.numberOfLines = 3;
        
        _label.textColor = [UIColor colorWithRGBHex:0x707070];
        
        _label.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (UILabel *)campaignNameLbl
{
    if (!_campaignNameLbl)
    {
        _campaignNameLbl = [[UILabel alloc] init];
        
        _campaignNameLbl.font = [UIFont boldSystemFontOfSize:14];
        
        _campaignNameLbl.backgroundColor = [UIColor clearColor];
        
        _campaignNameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _campaignNameLbl.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_campaignNameLbl];
    }
    return _campaignNameLbl;
}

+ (CGFloat)heightOfCell:(NSString *)campaignDescription
{
    CGSize size = [campaignDescription sizeWithFont:[UIFont boldSystemFontOfSize:13.0] constrainedToSize:CGSizeMake(160, 60)];
    
    CGFloat height1 =size.height + 52;
    
    CGFloat height =height1>106?height1:106;
    
    return height;
}



@end
