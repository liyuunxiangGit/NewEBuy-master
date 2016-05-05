
//
//  ReturnGoodsSubmitInfoCell.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsSubmitInfoCell.h"

#define   DefaultCellHeight      25.0f
#define   DefaultFont            [UIFont systemFontOfSize:13.0]


@implementation ReturnGoodsSubmitInfoCell



@synthesize productNameLbl = _productNameLbl;
@synthesize saleChannelLbl  = _saleChannelLbl;
@synthesize payTypeLbl = _payTypeLbl;
@synthesize productNoLbl = _productNoLbl;
@synthesize orderNumLbl = _orderNumLbl;
@synthesize productPriceLbl = _productPriceLbl;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderNumLbl);
    TT_RELEASE_SAFELY(_payTypeLbl);
    TT_RELEASE_SAFELY(_saleChannelLbl);
    TT_RELEASE_SAFELY(_productNameLbl);
    TT_RELEASE_SAFELY(_productNoLbl);
    TT_RELEASE_SAFELY(_productPriceLbl);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
		self.autoresizesSubviews = YES;
        self.phoneButton.frame = CGRectMake(150, 150+10, 149, 19.5);
        self.connectButton.frame = CGRectMake(0, 150+10, 149, 18.5);
        self.lineView.frame = CGRectMake(8, 144, 284, 1);
        self.lineView2.frame = CGRectMake(150-10, 144, 1, 52);
    }
    return self;
}



- (UILabel *)orderNumLbl
{    
    
    if (!_orderNumLbl)
    {
        _orderNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, DefaultCellHeight)];
        
        _orderNumLbl.backgroundColor = [UIColor clearColor];
        
        _orderNumLbl.font = DefaultFont;
        
        _orderNumLbl.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_orderNumLbl];
    }
    
    return _orderNumLbl;
}


- (UILabel *)payTypeLbl
{    
    
    if (!_payTypeLbl)
    {
        _payTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, DefaultCellHeight, 280, DefaultCellHeight)];
        
        _payTypeLbl.backgroundColor = [UIColor clearColor];
        
        _payTypeLbl.font = DefaultFont;
        
        _payTypeLbl.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_payTypeLbl];
    }
    
    return _payTypeLbl;
}


- (UILabel *)productNameLbl
{    
    
    if (!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, DefaultCellHeight *2, 280, DefaultCellHeight)];
        
        _productNameLbl.backgroundColor = [UIColor clearColor];
        
        _productNameLbl.font = DefaultFont;
        
        _productNameLbl.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_productNameLbl];
    }
    
    return _productNameLbl;
}

- (UILabel *)productNoLbl
{    
    
    if (!_productNoLbl)
    {
        _productNoLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, DefaultCellHeight * 3, 130, DefaultCellHeight)];
        
        _productNoLbl.backgroundColor = [UIColor clearColor];
        
        _productNoLbl.font = DefaultFont;
        
        _productNoLbl.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_productNoLbl];
    }
    
    return _productNoLbl;
}


- (UILabel *)productPriceLbl
{    
    
    if (!_productPriceLbl)
    {
        _productPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.productNoLbl.right, DefaultCellHeight * 3, 150, DefaultCellHeight)];
        
        _productPriceLbl.backgroundColor = [UIColor clearColor];
        
        _productPriceLbl.font = DefaultFont;
        
        _productPriceLbl.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_productPriceLbl];
    }
    
    return _productPriceLbl;
}

- (UILabel *)saleChannelLbl
{    
    
    if (!_saleChannelLbl)
    {
        _saleChannelLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, DefaultCellHeight * 4, 280, DefaultCellHeight)];
        
        _saleChannelLbl.backgroundColor = [UIColor clearColor];
        
        _saleChannelLbl.font = DefaultFont;
        
        _saleChannelLbl.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_saleChannelLbl];
    }
    
    return _saleChannelLbl;
}

- (UIButton *)connectButton
{
    
    if (!_connectButton)
    {
       
        _connectButton = [[UIButton alloc]init];
        
        
        _connectButton.backgroundColor = [UIColor clearColor];
        [_connectButton setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image] forState:UIControlStateNormal];
        [_connectButton setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateHighlighted];
        [_connectButton setImage:[UIImage imageNamed:kOS_hewolianxi_disable_iamge] forState:UIControlStateDisabled];
        
        [self.contentView addSubview:_connectButton];
    }
    
    return _connectButton;
}

- (UIButton *)phoneButton
{
    
    if (!_phoneButton)
    {
       
        _phoneButton = [[UIButton alloc]init];
        
        
        _phoneButton.backgroundColor = [UIColor clearColor];
        [_phoneButton setImage:[UIImage imageNamed:@"ziyingdian-dianhua-normal.png"] forState:UIControlStateNormal];
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://4008365365"]])
        {
            _phoneButton.enabled = NO;
        }
        [self.contentView addSubview:_phoneButton];
    }
    
    return _phoneButton;
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
       // _lineView.contentMode = UIViewContentModeScaleAspectFill;
        
//        UIImage *image = [UIImage imageNamed:imageName];
//        UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        [_lineView setImage:[UIImage streImageNamed:@"line.png"] ];
        
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (UIImageView*)lineView2
{
    if(!_lineView2)
    {
        _lineView2 = [[UIImageView alloc] init];
        
        _lineView2.backgroundColor = [UIColor clearColor];
    
        [_lineView2 setImage:[UIImage streImageNamed:@"line.png"] ];
        
        
        [self.contentView addSubview:_lineView2];
    }
    
    return _lineView2;
    
}


- (void)setItem:(ReturnGoodsPrepareDTO *)prepareDto status:(int)status
{
    self.orderNumLbl.text = [L(@"order ID") stringByAppendingFormat:@"     %@",prepareDto.orderId];
    
    self.payTypeLbl.text = [L(@"Payment:") stringByAppendingFormat:@"   %@",prepareDto.policyDesc];
    
    self.productNameLbl.text = [L(@"ProductName") stringByAppendingFormat:@"   %@",prepareDto.productName];
    
    self.productNoLbl.text = [L(@"product num") stringByAppendingFormat:@"   %@",prepareDto.quantityValue];
    
    self.saleChannelLbl.text = [L(@"sale way") stringByAppendingFormat:@"   %@",prepareDto.channel];
    
    double yfbAmount = [prepareDto.returnYfbAmount doubleValue];
    
    double yhkAmount = [prepareDto.returnYhkAmount doubleValue];
    
    double totalAmount = yfbAmount+yhkAmount;
    
    if (![prepareDto.zstatus1 isEqualToString:@"C"] && totalAmount == 0.00f) {
        
        self.productPriceLbl.text = @"";
    }else{
        
        self.productPriceLbl.text = [NSString stringWithFormat:@"%@: ￥%0.2f%@",L(@"MyEBuy_MoneyAmount"),totalAmount,L(@"Constant_RMB")];
    }
    
    if (status == 1)
    {
        self.connectButton.enabled = YES;
        
    }
    else
    {
        self.connectButton.enabled = NO;

    }
}


@end
