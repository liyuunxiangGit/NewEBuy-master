//
//  OrderSubmitHeadCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-14.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "OrderSubmitHeadCell.h"

@implementation OrderSubmitHeadCell

@synthesize goodsTotalLbl = _goodsTotalLbl;
@synthesize priceAmountLbl = _priceAmountLbl;
@synthesize priceAmount = _priceAmount;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_goodsTotalLbl);
    TT_RELEASE_SAFELY(_priceAmount);
    TT_RELEASE_SAFELY(_priceAmountLbl);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor whiteColor];
        
		self.autoresizesSubviews = YES;
        
    }
    
    return self;
}

- (void)setPriceAmount:(NSString *)priceAmount
{
    if (_priceAmount != priceAmount)
    {
        
        _priceAmount = priceAmount;
        
        self.goodsTotalLbl.text = L(@"BTOrderNumber");
        
        NSString *eprice = [NSString stringWithFormat:@"%.2f", [_priceAmount?_priceAmount:0 doubleValue]];
        self.priceAmountLbl.text = [NSString stringWithFormat:@"￥%@",eprice];
    }
     [self setNeedsLayout];
}


-(void) layoutSubviews{
	
	[super layoutSubviews];
    
     /*  
    //add separate line
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9876];
    
    if (separatorLine == nil)
    {
        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(5, self.contentView.bottom-1, 310, 2)];
        
        separatorLine.tag = 9527;
        
        separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        
        [self.contentView addSubview:separatorLine];
        
        TT_RELEASE_SAFELY(separatorLine);
    }
    */
	
}


- (void)prepareForReuse
{
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9527];
    
    [separatorLine removeFromSuperview];
}


- (UILabel *)goodsTotalLbl
{
    if (!_goodsTotalLbl) 
    {
        _goodsTotalLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 110, 40)];
        
        _goodsTotalLbl.backgroundColor = [UIColor clearColor];
        
        _goodsTotalLbl.textColor = [UIColor blackColor];
        
        _goodsTotalLbl.font = [UIFont boldSystemFontOfSize:19.0f];
        
        [self.contentView addSubview:_goodsTotalLbl];
    }
    
    return _goodsTotalLbl;
}

- (UILabel *)priceAmountLbl
{
    if (!_priceAmountLbl)
    {
		_priceAmountLbl = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 170, 40)];
		
		_priceAmountLbl.backgroundColor = [UIColor clearColor];
        
        _priceAmountLbl.textColor = [UIColor darkRedColor];
        
		_priceAmountLbl.font = [UIFont boldSystemFontOfSize:23];
        
        [self.contentView addSubview:_priceAmountLbl];
		
    }
    
    return _priceAmountLbl;
}


@end
