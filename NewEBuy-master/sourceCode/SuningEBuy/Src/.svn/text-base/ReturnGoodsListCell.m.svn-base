//
//  ReturnGoodsListCell.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsListCell.h"



#define   DefaultCellHeight      20.0f
#define   DefaultFont            [UIFont systemFontOfSize:15.0]
#define   DefaultColor           RGBCOLOR(46, 46, 46)

@implementation ReturnGoodsListCell

@synthesize  productName = _productName;

@synthesize orderNum = _orderNum;

@synthesize productPayTime = _productPayTime;

@synthesize productImage = _productImage;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_productName);
    
    TT_RELEASE_SAFELY(_orderNum);
    
    TT_RELEASE_SAFELY(_productPayTime);
    
    TT_RELEASE_SAFELY(_productImage);
    
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor cellBackViewColor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
		self.autoresizesSubviews = YES;

    }
    return self;
}

- (EGOImageViewEx *)productImage
{
    
    if (!_productImage)
    {
        
        
        UIView *contentView = [[UIView alloc] init];
        
        contentView.frame = CGRectMake(8, 8, 64, 64);
        
        [contentView.layer setShadowOffset:CGSizeMake(-0.25, 0.2)];
        
        [contentView.layer setShadowRadius:1];
        
        contentView.layer.backgroundColor = [UIColor clearColor].CGColor;
        
        contentView.layer.cornerRadius = 8.0;
        
        [contentView.layer setShadowColor:[UIColor grayColor].CGColor];
        
        [contentView.layer setShadowOpacity:0.4];
        
        _productImage = [[EGOImageViewEx alloc] init];
        
        _productImage.backgroundColor = [UIColor clearColor];
        
        _productImage.frame = CGRectMake(0, 0, 64, 64);
        
        _productImage.exDelegate = self;
        
        _productImage.delegate = self;
        
        _productImage.layer.cornerRadius = 5;
        
        _productImage.layer.masksToBounds = YES;
        
        _productImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        _productImage.userInteractionEnabled = YES;
        
        _productImage.contentMode = UIViewContentModeScaleToFill;
        
        [contentView addSubview:_productImage];
        
        [self.contentView addSubview:contentView];
        
    }
    return _productImage;
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_lineView setImage:[UIImage streImageNamed:@"fengexian-xuxian.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (UILabel *)orderNum
{    
    
    if (!_orderNum)
    {
        _orderNum = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, DefaultCellHeight)];
        
        _orderNum.backgroundColor = [UIColor clearColor];
        
        _orderNum.font = DefaultFont;
        
        _orderNum.textColor = DefaultColor;
        
        [self.contentView addSubview:_orderNum];
    }
    
    return _orderNum;
}

- (UILabel *)productName
{    
    
    if (!_productName)
    {
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(80,  self.orderNum.bottom , 200, DefaultCellHeight)];
        
        _productName.backgroundColor = [UIColor clearColor];
        
        _productName.textColor = DefaultColor;
        
        _productName.font = DefaultFont;
        
        [self.contentView addSubview:_productName];
    }
    
    return _productName;
}

- (UILabel *)productPayTime
{    
    
    if (!_productPayTime)
    {
        _productPayTime = [[UILabel alloc] initWithFrame:CGRectMake(80, self.productName.bottom , 200, DefaultCellHeight)];
        
        _productPayTime.backgroundColor = [UIColor clearColor];
        
        _productPayTime.font = DefaultFont;
        
        _productPayTime.textColor = DefaultColor;
        
        [self.contentView addSubview:_productPayTime];
    }
    
    return _productPayTime;
}

- (void)setItem:(ReturnGoodsListDTO *)item{

    if (item == nil) {
        
        return;
    }
    
    if (_item != item) {
        
        
        _item = item;
        
        self.orderNum.text =[NSString stringWithFormat:@"%@:     %@",L(@"MyEBuy_OrderId"),_item.orderId];
        
        self.productPayTime.text = [NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_SubmissionTime"),_item.orderTime];
        
        self.productName.text = [NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_ProductName"),_item.productName];
        
        self.productImage.imageURL = _item.productImage;
        self.lineView.frame = CGRectMake(8, 79, 284, 1);
    }
    
}

@end
