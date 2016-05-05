//
//  ShopOrderItemCell.m
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopOrderItemCell.h"
#import "ProductUtil.h"
#import "orderHttpDataSource.h"
#import "UITableViewCell+BgView.h"

#define KOrderStatusOriginX 5
#define KOrderStatusOriginY 85

@implementation ShopOrderItemCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)refreshCell:(ShopOrderItemListDto *)productDto
          orderDto:(ShopOrderListDto *)orderDto
          cellType:(CellViewType)cellType
{
    
    if (IsNilOrNull(productDto) || IsNilOrNull(orderDto))
    {
        return;
    }
    
    
    if (cellType == MiddleCell) {
        
        [self setCoolBgViewWithCellPosition:CellPositionCenter hasLine:NO];
        
    }else{
        
        [self setCoolBgViewWithCellPosition:CellPositionBottom hasLine:NO];
        }
    
    
    self.iconImageView.frame = CGRectMake(10, 10, 60, 60);
    self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.commodityCode size:100];
    
    self.productNameLbl.frame = CGRectMake(80, 5, 190, 30);
    self.productNameLbl.text = productDto.commodityName;
    
    self.priceLbl.frame = CGRectMake(80, _productNameLbl.bottom, 100, 20);
    self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[productDto.unitPrice doubleValue]];
    
    self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, _productNameLbl.bottom, 85, 20);
    self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[productDto.saleCount intValue]];
    
    self.supplierLbl.frame = CGRectMake(80, _productNumLbl.bottom, 180, 20);
   
    self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
    
    self.accessView.frame = CGRectMake(280, 32, 8, 15);
    
    
    [self setAButtonsPosiotion:orderDto WithProduct:productDto];
    
    
    self.lineView1.frame = CGRectMake(10, 0, 280, 1);
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
- (void)setAButtonsPosiotion:(ShopOrderListDto *)dto
                 WithProduct:(ShopOrderItemListDto *)productDto
{
    self.orderStatusLbl.hidden = NO;
    
    self.orderStatusLbl.frame = CGRectMake(10, _supplierLbl.bottom+15, 100, 20);
    
    self.orderStatusLbl.text = [self setOrderStatus:productDto.orderItemStatus];
    
    self.snxpressQueryBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
    
    self.snxpressQueryBtn.hidden = NO;
    
}


#pragma mark -
#pragma mark UIView

-(UIImageView *)backView{
    
    if (!_backView) {
        
        _backView = [[UIImageView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.image = [UIImage streImageNamed:@"yellow_mid@2x.png"];
    }
    return _backView;
}

-(EGOImageButton *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[EGOImageButton alloc]init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

-(UILabel *)productNameLbl{
    
    if (!_productNameLbl) {
        _productNameLbl = [[UILabel alloc]init];
        _productNameLbl.backgroundColor = [UIColor clearColor];
        _productNameLbl.font = [UIFont systemFontOfSize:13];
        _productNameLbl.textColor = RGBCOLOR(68, 68, 68);
        _productNameLbl.numberOfLines = 2;
        [self.contentView addSubview:_productNameLbl];
    }
    return _productNameLbl;
}

-(UILabel *)supplierLbl{
    
    if (!_supplierLbl) {
        _supplierLbl = [[UILabel alloc]init];
        _supplierLbl.backgroundColor = [UIColor clearColor];
        _supplierLbl.font = [UIFont systemFontOfSize:13];
        _supplierLbl.textColor = RGBCOLOR(137, 137, 137);
        [self.contentView addSubview:_supplierLbl];
    }
    return _supplierLbl;
}

-(UILabel *)priceLbl{
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]init];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.font = [UIFont systemFontOfSize:13];
        _priceLbl.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}

-(UILabel *)productNumLbl{
    
    if (!_productNumLbl) {
        _productNumLbl = [[UILabel alloc]init];
        _productNumLbl.backgroundColor = [UIColor clearColor];
        _productNumLbl.font = [UIFont systemFontOfSize:13];
        _productNumLbl.textColor = RGBCOLOR(137, 137, 137);
        [self.contentView addSubview:_productNumLbl];
    }
    return _productNumLbl;
}

-(UIImageView *)lineView1{
    
    if (!_lineView1) {
        
        _lineView1 = [[UIImageView alloc]init];
        _lineView1.backgroundColor = [UIColor clearColor];
        _lineView1.image = [UIImage streImageNamed:@"new_order_line.png"];
        [self.contentView addSubview:_lineView1];
    }
    return _lineView1;
}

-(UIImageView *)accessView{
    
    if (!_accessView) {
        
        _accessView = [[UIImageView alloc]init];
        _accessView.backgroundColor = [UIColor clearColor];
        _accessView.image = [UIImage streImageNamed:@"New_Arrow_right_btn.png"];
        [self.contentView addSubview:_accessView];
    }
    return _accessView;
}

- (UILabel*)orderStatusLbl
{
    if(!_orderStatusLbl)
    {
        _orderStatusLbl = [[UILabel alloc] init];
        _orderStatusLbl.textColor = RGBCOLOR(137, 137, 137);
        _orderStatusLbl.backgroundColor = [UIColor clearColor];
        _orderStatusLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_orderStatusLbl];
    }
    return _orderStatusLbl;
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

@end
