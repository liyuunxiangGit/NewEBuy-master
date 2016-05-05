//
//  NProDetailShopExitCell.m
//  SuningEBuy
//
//  Created by xmy on 23/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailShopExitCell.h"

@implementation NProDetailShopExitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLblProtery:(UILabel*)lbl
{
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.textColor = [UIColor blackColor];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.numberOfLines = 2;
    
    lbl.hidden = NO;
    
}

- (UILabel*)shopNumInfoLbl
{
    if(!_shopNumInfoLbl)
    {
        _shopNumInfoLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_shopNumInfoLbl];
        
        _shopNumInfoLbl.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _shopNumInfoLbl;
}

- (UIImageView*)backView
{
    if(!_backView)
    {
        _backView = [[UIImageView alloc] init];
        
        [_backView setImage:[UIImage imageNamed:nil]];
        
        _backView.backgroundColor = [UIColor whiteColor];
        
        _backView.userInteractionEnabled = YES;
    }
    
    return _backView;
}

- (UIImageView *)seperateLineOne
{
    if (!_seperateLineOne) {
        _seperateLineOne = [[UIImageView alloc] init];
        
        _seperateLineOne.image = [UIImage streImageNamed:@"line.png"];
    }
    return _seperateLineOne;
}

- (UIImageView *)seperateLineTwo
{
    if (!_seperateLineTwo) {
        _seperateLineTwo = [[UIImageView alloc] init];
        
        _seperateLineTwo.image = [UIImage streImageNamed:@"line.png"];
    }
    return _seperateLineTwo;
}

- (UIImageView*)arrowImageV
{
    if(!_arrowImageV)
    {
        
        _arrowImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        
        _arrowImageV.frame = CGRectMake(300, 15, 18/2, 29/2);
        
        _arrowImageV.backgroundColor = [UIColor clearColor];
        
    }
    
    return _arrowImageV;
}

- (void)setNProDetailShopExitCellInfo:(DataProductBasic *)dto
{
    if(dto == nil)
    {
        return;
    }
    
    if([dto.shopSize intValue] > 1)
    {
        self.shopNumInfoLbl.hidden = NO;
        self.backView.hidden = NO;
        self.arrowImageV.hidden = NO;
        self.seperateLineOne.hidden = NO;
        self.seperateLineTwo.hidden = NO;
        
        [self.contentView addSubview:self.backView];
        
        [self.backView addSubview:self.shopNumInfoLbl];
        
        [self.backView addSubview:self.arrowImageV];
        
        [self.backView addSubview:self.seperateLineOne];
        [self.backView addSubview:self.seperateLineTwo];
        
        self.shopNumInfoLbl.text = [NSString stringWithFormat:@"%@ (%@)",L(@"Product_AllGoodSeller"),dto.shopSize];
        
        self.shopNumInfoLbl.frame = CGRectMake(15, 0, 200, 35);
        
        self.backView.frame = CGRectMake(0, 0, 320, 40);
        
        self.arrowImageV.frame = CGRectMake(295, 12, 18/2, 29/2);
        
        self.seperateLineOne.frame = CGRectMake(0, self.backView.bottom - 0.5, 320, 0.5);
        self.seperateLineTwo.frame = CGRectMake(0, 0, 320, 0.5);
    }
    else
    {
        self.shopNumInfoLbl.hidden = YES;
        self.backView.hidden = YES;
        self.arrowImageV.hidden = YES;
        self.seperateLineOne.hidden = YES;
        self.seperateLineTwo.hidden = YES;
    }
    
}

+ (CGFloat)NProDetailShopExitCellHeight:(DataProductBasic *)dto
{
    if([dto.shopSize intValue] > 1)
    {
        return 55;

    }
    else
    {
        return 0;
    }
}

@end
