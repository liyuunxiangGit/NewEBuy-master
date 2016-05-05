//
//  GBOrderListCell.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderListCell.h"

@implementation GBOrderListCell

@synthesize nameLbl = _nameLbl;

@synthesize numberContentLbl = _numberContentLbl;
@synthesize numberLbl = _numberLbl;

@synthesize orderStateContentLbl = _orderStateContentLbl;
@synthesize orderStateLbl = _orderStateLbl;

@synthesize priceLbl = _priceLbl;
@synthesize item = _item;
@synthesize image = _image;
@synthesize orderStateList = _orderStateList;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.orderStateList = @[L(@"PVWaitForPay"),L(@"PVPaid"),L(@"PVPaid"),L(@"PVCanceled"),L(@"PVRefunding"),L(@"PVRefunded"),L(@"PVCanceled")];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
    
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(_nameLbl);
    TT_RELEASE_SAFELY(_numberContentLbl);
    TT_RELEASE_SAFELY(_numberLbl);
    TT_RELEASE_SAFELY(_orderStateContentLbl);
    TT_RELEASE_SAFELY(_orderStateLbl);
    TT_RELEASE_SAFELY(_priceLbl);
    TT_RELEASE_SAFELY(_image);
    TT_RELEASE_SAFELY(_item);
    
}

- (UILabel *)nameLbl
{
    if (!_nameLbl)
    {
        _nameLbl = [[UILabel alloc] init];
        
        _nameLbl.font = [UIFont boldSystemFontOfSize:14];
        
        _nameLbl.backgroundColor = [UIColor clearColor];
        _nameLbl.numberOfLines  = 0;
        _nameLbl.shadowColor = [UIColor whiteColor];
        _nameLbl.shadowOffset = CGSizeMake(1, 1);
        _nameLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_nameLbl];
    }
    return _nameLbl;
}

- (UILabel *)numberContentLbl
{
    if (!_numberContentLbl)
    {
        _numberContentLbl = [[UILabel alloc] init];
        _numberContentLbl.font = [UIFont boldSystemFontOfSize:14];
        _numberContentLbl.backgroundColor = [UIColor clearColor];
        _numberContentLbl.text = L(@"LBAmount");
        _numberContentLbl.shadowColor = [UIColor whiteColor];
        _numberContentLbl.shadowOffset = CGSizeMake(1, 1);
        [self.contentView addSubview:_numberContentLbl];
    }
    return _numberContentLbl;
}

- (UILabel *)numberLbl
{
    if (!_numberLbl)
    {
        _numberLbl = [[UILabel alloc] init];
        _numberLbl.font = [UIFont boldSystemFontOfSize:14];
        _numberLbl.backgroundColor = [UIColor clearColor];
        _numberLbl.shadowColor = [UIColor whiteColor];
        _numberLbl.shadowOffset = CGSizeMake(1, 1);
        _numberLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_numberLbl];
    }
    return _numberLbl;
}

- (UILabel *)orderStateContentLbl
{
    if (!_orderStateContentLbl)
    {
        _orderStateContentLbl = [[UILabel alloc] init];
        _orderStateContentLbl.font = [UIFont boldSystemFontOfSize:14];
        _orderStateContentLbl.backgroundColor = [UIColor clearColor];
        _orderStateContentLbl.text = L(@"LBOrderListState");
        _orderStateContentLbl.shadowColor = [UIColor whiteColor];
        _orderStateContentLbl.shadowOffset = CGSizeMake(1, 1);
        [self.contentView addSubview:_orderStateContentLbl];
    }
    return _orderStateContentLbl;
}

- (UILabel *)orderStateLbl
{
    if (!_orderStateLbl)
    {
        _orderStateLbl = [[UILabel alloc] init];
        _orderStateLbl.font = [UIFont boldSystemFontOfSize:14];
        _orderStateLbl.backgroundColor = [UIColor clearColor];
        _orderStateLbl.shadowColor = [UIColor whiteColor];
        _orderStateLbl.shadowOffset = CGSizeMake(1, 1);
        _orderStateLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_orderStateLbl];
    }
    return _orderStateLbl;
}

- (UILabel *)priceLbl
{
    if (!_priceLbl)
    {
        _priceLbl = [[UILabel alloc] init];
        _priceLbl.font = [UIFont boldSystemFontOfSize:16];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.shadowColor = [UIColor whiteColor];
        _priceLbl.shadowOffset = CGSizeMake(1, 1);
        _priceLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}

-(UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        _image.backgroundColor = [UIColor clearColor];
        _image.frame = CGRectMake(245, 20, 10, 15);
        [self.contentView addSubview:_image];
    }
    return _image;
}

+(CGFloat) height:(GBOrderInfoDTO *)item{
	
	if (!item) {
		
		return ORDER_LIST_CELL_HEIGHT;
	}
	
	
	return  ORDER_LIST_CELL_HEIGHT;
	
}

- (void) setItem:(GBOrderInfoDTO *)item{
//    if (_item !=item) {
//        
        _item = item;
    self.nameLbl.text = _item.snProName;
    self.numberLbl.text  = _item.saleCount;
    if (!IsStrEmpty(_item.orderAmount))
    {
        self.priceLbl.text = [NSString stringWithFormat:@"￥%@",_item.orderAmount];
    }
    self.orderStateLbl.text = item.statusName;//[self.orderStateList objectAtIndex:item.orderStatus];

  // [self setNeedsLayout];
    
//    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLbl.frame = CGRectMake(20, 15, 300, 30);
    
    self.numberContentLbl.frame = CGRectMake(20, self.nameLbl.bottom, 50, 30);
    
    self.numberLbl.frame = CGRectMake(self.numberContentLbl.right, self.nameLbl.bottom, 50, 30);
    
    self.image.frame = CGRectMake(270, self.numberLbl.top+7, 10, 15);
    
    self.orderStateContentLbl.frame = CGRectMake(20, self.numberContentLbl.bottom, 80, 30);
    
    self.orderStateLbl.frame = CGRectMake(self.orderStateContentLbl.right, self.numberContentLbl.bottom, 80, 30);
    
    self.priceLbl.frame = CGRectMake(190, self.numberContentLbl.bottom, 100, 30);
}
@end
