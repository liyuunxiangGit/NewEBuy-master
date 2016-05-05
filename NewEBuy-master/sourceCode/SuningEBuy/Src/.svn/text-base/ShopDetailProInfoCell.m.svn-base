//
//  ShopDetailProInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopDetailProInfoCell.h"

#import "ProductUtil.h"
#import "UITableViewCell+BgView.h"

#define  KNewProOriginX 5

#define  KNewProOriginY 5

@implementation ShopDetailProInfoCell

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
    lbl.textColor = RGBCOLOR(68, 68, 68);//[UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = RGBCOLOR(68, 68, 68);//[UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
}

- (UILabel*)productNameLbl
{
    if(!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_productNameLbl];
        
        _productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        
        _productNameLbl.numberOfLines = 2;
        
        [self.contentView addSubview:_productNameLbl];
    }
    
    return _productNameLbl;
}

- (UILabel*)shopContextLbl
{
    if(!_shopContextLbl)
    {
        _shopContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_shopContextLbl];
        
        _shopContextLbl.textColor = RGBCOLOR(137, 137, 137);;
        
        [self.contentView addSubview:_shopContextLbl];
    }
    
    return _shopContextLbl;
    
}


- (UILabel*)productPriceContextLbl
{
    if(!_productPriceContextLbl)
    {
        _productPriceContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_productPriceContextLbl];
        
        _productPriceContextLbl.textColor = [UIColor redColor];
        
        [self.contentView addSubview:_productPriceContextLbl];
    }
    
    return _productPriceContextLbl;
}

- (UILabel*)yangLbl
{
    if(!_yangLbl)
    {
        _yangLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_yangLbl];
        
        _yangLbl.text = @"¥";
        
        [self.contentView addSubview:_yangLbl];
    }
    
    return _yangLbl;
    
}


- (UILabel*)productNumLbl
{
    if(!_productNumLbl)
    {
        _productNumLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_productNumLbl];
        
        _productNumLbl.text = [NSString stringWithFormat:@"%@:",L(@"Constant_Amount")];
        
        _productNumLbl.textColor = RGBCOLOR(137, 137, 137) ;//[UIColor blackColor];
        
        [self.contentView addSubview:_productNumLbl];
    }
    
    return _productNumLbl;
    
}

- (UILabel*)productNumContextLbl
{
    if(!_productNumContextLbl)
    {
        _productNumContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_productNumContextLbl];
        
        [self.contentView addSubview:_productNumContextLbl];
    }
    
    return _productNumContextLbl;
}



- (EGOImageView*)productImageV
{
    if(!_productImageV)
    {
        _productImageV = [[EGOImageView alloc] init];
        
        _productImageV.backgroundColor = [UIColor clearColor];
        
        _productImageV.frame = CGRectMake(5, 5, 60, 60);
        
        _productImageV.contentMode = UIViewContentModeScaleAspectFill;
        
        _productImageV.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        
        _productImageV.layer.masksToBounds = YES;
        
        _productImageV.layer.cornerRadius = 0.5;
        
        [self.contentView addSubview:_productImageV];
    }
    
    return _productImageV;
    
}


- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(10, 5, 280, 1);
        
        _lineView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_lineView setImage:[UIImage streImageNamed:@"new_order_line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (UILabel*)orderStatusContextLbl
{
    if(!_orderStatusContextLbl)
    {
        _orderStatusContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_orderStatusContextLbl];
        
        _orderStatusContextLbl.textColor = RGBCOLOR(137, 137, 137);
        
        [self.contentView addSubview:_orderStatusContextLbl];
    }
    
    return _orderStatusContextLbl;
    
}


- (UIButton*)snxpressQueryBtn
{
    if(!_snxpressQueryBtn)
    {
        _snxpressQueryBtn = [[UIButton alloc] init];
        
        [_snxpressQueryBtn setTitle:L(@"MyEBuy_CheckExpress") forState:UIControlStateNormal];
        
        [_snxpressQueryBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        [_snxpressQueryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _snxpressQueryBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"right_item_light_btn.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_snxpressQueryBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        
        [self.contentView addSubview:_snxpressQueryBtn];
    }
    
    return _snxpressQueryBtn;
}

-(UIImageView *)lineView2{
    
    if (!_lineView2) {
        
        _lineView2 = [[UIImageView alloc]init];
        _lineView2.backgroundColor = [UIColor clearColor];
        _lineView2.image = [UIImage streImageNamed:@"new_order_line.png"];
        [self.contentView addSubview:_lineView2];
    }
    return _lineView2;
}
- (void)setShopDetailProInfoCellInfo:(ShopDetailDto *)dto
                         WithHeadDto:(ShopDetailItemDto *)itemDto
                        WithPosition:(NSInteger)cellRow
{
    
    if(cellRow == 0)
    {
        [self setCoolBgViewWithCellPosition:CellPositionSingle];

    }
    else if(cellRow == 1)
    {
        [self setCoolBgViewWithCellPosition:CellPositionTop];
        
    }
    else if(cellRow == 2)
    {
        [self setCoolBgViewWithCellPosition:CellPositionCenter];
        
    }
    else if(cellRow == 3)
    {
        [self setCoolBgViewWithCellPosition:CellPositionBottom];
        
    }

    
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:itemDto.commodityCode size:ProductImageSize160x160];
    }
    else{
        
        self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:itemDto.commodityCode size:ProductImageSize120x120];
    }
    
    
    self.productNameLbl.text = itemDto.commodityName;
   
    self.shopContextLbl.text = L(@"MyEBuy_SuningSelf");
        
        
    self.productNumContextLbl.text =[NSString stringWithFormat:@"%i",[itemDto.saleCount intValue]] ;
    
    NSString *marketPrice = [NSString stringWithFormat:@"%.2f",[itemDto.unitPrice floatValue]];
    
    self.productPriceContextLbl.text = marketPrice;
    
    self.productImageV.frame = CGRectMake(KNewProOriginX, KNewProOriginY, 60, 60);
    
    self.productNameLbl.frame = CGRectMake(self.productImageV.right+5, KNewProOriginY, 218, 30 );
    self.productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
    self.productNameLbl.numberOfLines = 2;
    
    
    self.yangLbl.frame = CGRectMake(self.productImageV.right+5, self.productNameLbl.bottom, 10, 20 );
    
    self.productPriceContextLbl.frame = CGRectMake(self.yangLbl.right, self.productNameLbl.bottom, 70, 20 );
    
    self.productNumLbl.frame = CGRectMake(self.productPriceContextLbl.right, self.productNameLbl.bottom, 30, 20 );
    self.productNumContextLbl.frame = CGRectMake(self.productNumLbl.right, self.productNameLbl.bottom, 40, 20 );
    
    self.shopContextLbl.frame = CGRectMake(self.productImageV.right+5, self.productPriceContextLbl.bottom, 218, 20 );
    self.shopContextLbl.numberOfLines = 1;
    self.shopContextLbl.lineBreakMode = UILineBreakModeTailTruncation;
    
    [self setAButtonsPosiotion:dto WithProduct:itemDto];
    
    self.lineView2.frame = CGRectMake(10, 80, 280, 1);
    
}

- (NSString*)setOrderStatus:(NSString*)status
{
    NSString *str = nil;
    
    //    订单行状态（包括线上订单、门店订单）有：10 已提交;12 处理异常;20 已处理;30 已生效;40 已出库;50  货到付款已收已付;60 已完成;70 拒收退货;80 取消;15 退换货处理中;58 冲红完成;75 退款完成。
    if([status isEqualToString:@"10"])
    {
        str = L(@"MyEBuy_Submitted");
    }
    else if([status isEqualToString:@"12"])
    {
        str = L(@"MyEBuy_ExceptionHandling");
    }
    else if([status isEqualToString:@"20"])
    {
        str = L(@"MyEBuy_Processed");
    }
    else if([status isEqualToString:@"30"])
    {
        str = L(@"MyEBuy_Effected");
    }
    else if([status isEqualToString:@"40"])
    {
        str = L(@"MyEBuy_Outbounded");
    }
    else if([status isEqualToString:@"50"])
    {
        str = L(@"MyEBuy_CashOnDelivery_ReceivedAndPaid");
    }
    else if([status isEqualToString:@"60"])
    {
        str = L(@"MyEBuy_Completed");
    }
    else if([status isEqualToString:@"80"])
    {
        str = L(@"Cancel");
    }
    else if([status isEqualToString:@"15"])
    {
        str = L(@"MyEBuy_ReturnsProcessing");
    }
    else if([status isEqualToString:@"75"])
    {
        str = L(@"MyEBuy_RedFinish");
    }
    else if([status isEqualToString:@"75"])
    {
        str = L(@"MyEBuy_RefundCompleted");
    }
    
    return str;
}


//ALL:全部订单
- (void)setAButtonsPosiotion:(ShopDetailDto *)dto
                 WithProduct:(ShopDetailItemDto *)productDto
{    
    self.orderStatusContextLbl.frame = CGRectMake(10, self.shopContextLbl.bottom+15, 100, 20);
    
    self.orderStatusContextLbl.text = [self setOrderStatus:productDto.orderItemStatus];
    
    self.snxpressQueryBtn.frame = CGRectMake(192, 85, 100, 30);
    
    self.snxpressQueryBtn.hidden = NO;
    
}
+ (CGFloat)setShopDetailProInfoCellHeight:(ShopDetailDto *)dto
{
    return 163;
}

@end
