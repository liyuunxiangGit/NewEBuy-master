//
//  CShopApplicationCell.m
//  //
//
//  Created by 荀晓冬 on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopApplicationCell.h"
#define   DefaultCellHeight      25.0f
#define   DefaultFont            [UIFont systemFontOfSize:14.0]

@implementation CShopApplicationCell

@synthesize productNameLbl = _productNameLbl;
@synthesize saleChannelLbl  = _saleChannelLbl;
@synthesize severTypeLbl = _severTypeLbl;
@synthesize productNoLbl = _productNoLbl;
@synthesize orderNumLbl = _orderNumLbl;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderNumLbl);
    TT_RELEASE_SAFELY(_severTypeLbl);
    TT_RELEASE_SAFELY(_saleChannelLbl);
    TT_RELEASE_SAFELY(_productNameLbl);
    TT_RELEASE_SAFELY(_productNoLbl);
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor cellBackViewColor];
		self.autoresizesSubviews = YES;
        
        
    }
    return self;
}

- (UILabel *)orderNumLbl
{
    
    if (!_orderNumLbl)
    {
        //_orderNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, DefaultCellHeight)];
        _orderNumLbl = [[UILabel alloc]init];
        
        _orderNumLbl.backgroundColor = [UIColor clearColor];
        
        _orderNumLbl.font = DefaultFont;
        
        _orderNumLbl.textColor = RGBCOLOR(46, 46, 46);
        _orderNumLbl.numberOfLines = 0;
        
        [self.contentView addSubview:_orderNumLbl];
    }
    
    return _orderNumLbl;
}



- (UILabel *)productNameLbl
{
    
    if (!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, self.orderNumLbl.bottom+15, 280, DefaultCellHeight)];
        
        _productNameLbl.backgroundColor = [UIColor clearColor];
        
        _productNameLbl.font = DefaultFont;
        
        _productNameLbl.textColor = RGBCOLOR(46, 46, 46);
        
        //[self.contentView addSubview:_productNameLbl];
    }
    
    return _productNameLbl;
}

- (UILabel *)productNoLbl
{
    
    if (!_productNoLbl)
    {
        _productNoLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, self.productNameLbl.bottom+15, 130, DefaultCellHeight)];
        
        _productNoLbl.backgroundColor = [UIColor clearColor];
        
        _productNoLbl.font = DefaultFont;
        
        _productNoLbl.textColor = RGBCOLOR(46, 46, 46);
        
        //[self.contentView addSubview:_productNoLbl];
    }
    
    return _productNoLbl;
}



- (UILabel *)saleChannelLbl
{
    
    if (!_saleChannelLbl)
    {
        _saleChannelLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, self.productNoLbl.bottom+15, 280, DefaultCellHeight)];
        
        _saleChannelLbl.backgroundColor = [UIColor clearColor];
        
        _saleChannelLbl.font = DefaultFont;
        
        _saleChannelLbl.textColor = RGBCOLOR(46, 46, 46);
        
        //[self.contentView addSubview:_saleChannelLbl];
    }
    
    return _saleChannelLbl;
}


- (UIButton *)cShopConnect
{
    
    if (!_cShopConnect)
    {
        
        _cShopConnect = [[UIButton alloc]init];
        
        
        _cShopConnect.backgroundColor = [UIColor clearColor];
         [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateNormal];
        //[_cShopConnect setBackgroundImage:[UIImage imageNamed:@"Cdian-hewolianxi-Press.png"] forState:UIControlStateHighlighted];
        
        //_connectButton.font = DefaultFont;
        
        // _connectButton.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_cShopConnect];
    }
    
    return _cShopConnect;
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        
        
       // _lineView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"] ];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (void)setItem:(ReturnGoodsPrepareDTO *)prepareDto status:(int)status
{
//    NSString *orderNumLblT = [NSString stringWithFormat:@"订单号: %@\n\n商品名称: %@\n\n商品数量: %@\n\n销售渠道: %@",prepareDto.orderId?prepareDto.orderId:@"",prepareDto.productName?prepareDto.productName:@"",prepareDto.quantityValue?prepareDto.quantityValue:@"",prepareDto.vendorCShopName?prepareDto.vendorCShopName:@""];
//    CGSize size = [orderNumLblT sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
//    self.orderNumLbl.frame = CGRectMake(10, 10, size.width, size.height);
//    self.orderNumLbl.text = orderNumLblT;

    self.orderNumLbl.hidden = YES;
    
    if (status != -1)
    {
        self.lineView.frame = CGRectMake(0, 0.5, 320, 0.5);
        self.cShopConnect.frame = CGRectMake(30+20+20, 10, 149, 18.5);
        _lineView.hidden = NO;
        _cShopConnect.hidden = NO;
        
        if (status == 1) //在线
        {
            [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image] forState:UIControlStateNormal];
            [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateHighlighted];
        }
        else    //不在线
        {
            
            
            [_cShopConnect setImage:[UIImage imageNamed:kOS_lixianliuyan_image] forState:UIControlStateNormal];
            [_cShopConnect setImage:[UIImage imageNamed:kOS_lixianliuyan_image_clicked] forState:UIControlStateHighlighted];
        }
    }
    else    //未接入
    {
        _lineView.hidden = YES;
        _cShopConnect.hidden = YES;
    }
    
    
}

+ (CGFloat)height:(ReturnGoodsPrepareDTO *)prepareDto status:(int)status;
{
//    NSString *orderNumLblT = [NSString stringWithFormat:@"订单号: %@\n\n商品名称: %@\n\n商品数量: %@\n\n销售渠道: %@",prepareDto.orderId?prepareDto.orderId:@"",prepareDto.productName?prepareDto.productName:@"",prepareDto.quantityValue?prepareDto.quantityValue:@"",prepareDto.vendorCShopName?prepareDto.vendorCShopName:@""];
//    CGSize size = [orderNumLblT sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    if (status != -1)
    {
        return 40;//10 + size.height + 20 + 32 + 10;
    }
    else
    {
        return 0;//10 + size.height + 10;
    }
    
}


@end
