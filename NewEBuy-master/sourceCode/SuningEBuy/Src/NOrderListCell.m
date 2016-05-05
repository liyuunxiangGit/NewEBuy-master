//
//  NOrderListCell.m
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NOrderListCell.h"
#import "ProductUtil.h"
#import "orderHttpDataSource.h"
#import "UITableViewCell+BgView.h"

#define KOrderStatusOriginX 5
#define KOrderStatusOriginY 85

@implementation NOrderListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)refreshCell:(ProductListDTO *)productDto
          orderDto:(NewOrderListDTO *)orderDto
          cellType:(CellViewType)cellType
   listOrderStatus:(NSString*)statusListStr
{
    
    if (IsNilOrNull(productDto) || IsNilOrNull(orderDto))
    {
        return;
    }
    
    
    if (cellType == MiddleCell) {
        
        [self setCoolBgViewWithCellPosition:CellPositionCenter hasLine:NO];

//        self.backView.image = [UIImage streImageNamed:@"yellow_mid@2x.png"];
    }else{
        
        [self setCoolBgViewWithCellPosition:CellPositionBottom hasLine:NO];

//        self.backView.image = [UIImage streImageNamed:@"yellow_buttom@2x.png"];
    }
//    self.backgroundView = self.backView;
    
    
    self.iconImageView.frame = CGRectMake(10, 10, 60, 60);
    self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.productCode size:100];
    
    self.productNameLbl.frame = CGRectMake(80, 5, 190, 30);
    self.productNameLbl.text = productDto.productName;
    
    self.priceLbl.frame = CGRectMake(80, _productNameLbl.bottom, 100, 20);
    self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[productDto.itemPrice doubleValue]];
    
    self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, _productNameLbl.bottom, 85, 20);
    self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[productDto.quantity intValue]];
    
    self.supplierLbl.frame = CGRectMake(80, _productNumLbl.bottom, 180, 20);
    if (IsStrEmpty(productDto.supplierCode))
    {
        self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
    }
    else{
        self.supplierLbl.text = productDto.supplierName;
    }
    
    
    self.accessView.frame = CGRectMake(280, 32, 8, 15);
    

    
    if([statusListStr isEqualToString:@"A"])
    {//全部订单
        [self setAButtonsPosiotion:orderDto WithProduct:productDto];
    }
    else
    {
        self.orderStatusLbl.hidden = NO;
        
        self.orderStatusLbl.frame = CGRectMake(10, _supplierLbl.bottom+15, 100, 20);
        self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:nil WithOrderStatus:statusListStr];
        
        if([statusListStr eq:@"C"] || [statusListStr hasPrefix:@"C000"]
           ||[statusListStr hasPrefix:@"C010"] || [statusListStr hasPrefix:@"C015"])
        {//支付完成订单，已发货订单，收货完成订单
            [self setCButtonsPosiotion:orderDto];
        }
        else if([statusListStr hasPrefix:@"M"])
        {//等待支付订单
            [self setMButtonsPosiotion:orderDto];
        }
        else if([statusListStr hasPrefix:@"W"])
        {//发货处理中订单
            [self setM1OrM2ButtonsPosiotion:orderDto];
        }
        else if([statusListStr eq:@"X"])
        {//已取消订单
            [self setXButtonsPosiotion:orderDto];
            
        }
        else if([statusListStr eq:@"R"])
        {//退货成功订单
            [self setRButtonsPosiotion:orderDto];
            
        }
        
        self.lineView1.frame = CGRectMake(10, 0, 280, 1);
        self.lineView2.frame = CGRectMake(10, 80, 280, 1);
        
        
    }
    
    
}


//A:全部订单
- (void)setAButtonsPosiotion:(NewOrderListDTO *)dto
                 WithProduct:(ProductListDTO *)productDto
{
    if([dto.oiStatus hasPrefix:@"M"] &&
       ![dto.ormOrder isEqualToString:@"11601"] &&
       ![dto.ormOrder isEqualToString:@"11701"] &&
       IsStrEmpty(dto.supplierCode))
    {//等待支付订单 中 非货到付款和非门店付款订单
        self.orderStatusLbl.hidden = YES;
        self.payBtn.hidden = YES;
        self.cancelOrderBtn.hidden = YES;
        
        self.lineView1.frame = CGRectMake(10, 0, 280, 1);
    }
    else
    {
        self.orderStatusLbl.hidden = NO;
        
        self.orderStatusLbl.frame = CGRectMake(10, _supplierLbl.bottom+15, 100, 20);
        self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:nil WithOrderStatus:dto.oiStatus];
        
        BOOL isFinishAccept = [dto isFinishAcceptOK:productDto.finishAccept];
        BOOL isDelivery = [dto isDelivityOK:productDto.omsStatus];
        
        
        
        if([dto.oiStatus hasPrefix:@"M"])
        {//等待支付订单
            
            if([dto.ormOrder isEqualToString:@"11601"])
            {//货到付款订单
                [self setM1OrM2ButtonsPosiotion:dto];
            }
            else
            {
                [self setMButtonsPosiotion:dto];
                
            }
        }
        else if(([dto.oiStatus eq:@"X"] ||
                 [dto.oiStatus eq:@"x"] ||
                 [dto.oiStatus eq:@"H"]))
        {//已取消订单
            [self setXButtonsPosiotion:dto];
            
        }
        else if(([dto.oiStatus eq:@"R"] ||
                 [dto.oiStatus eq:@"r"] ||
                 [dto.oiStatus eq:@"G"]))
        {//以退货订单
            [self setRButtonsPosiotion:dto];
            
        }
        else
        {
            if(isDelivery == YES)
            {
                self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:nil WithOrderStatus:@"C000"];
                self.orderStatusLbl.frame = CGRectMake(10, _supplierLbl.bottom+15, 100, 20);

                [self setCButtonsPosiotion:dto];
            }
            else if(isFinishAccept == YES)
            {
                self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:nil WithOrderStatus:@"C010"];
                self.orderStatusLbl.frame = CGRectMake(10, _supplierLbl.bottom+15, 100, 20);

                [self setCButtonsPosiotion:dto];
                
            }
            else if(([dto.oiStatus eq:@"C"] ||
                    [dto.oiStatus eq:@"c"] ||
                    [dto.oiStatus eq:@"D"] ||
                    [dto.oiStatus eq:@"E"] ||
                    [dto.oiStatus eq:@"F"]) &&
                    (isFinishAccept == NO && isDelivery == NO) )
            {//支付完成订单，已发货订单，收货完成订单
                [self setCButtonsPosiotion:dto];
            }
        }
        self.lineView1.frame = CGRectMake(10, 0, 280, 1);
        self.lineView2.frame = CGRectMake(10, 80, 280, 1);
        
    }
    
    
}


//C:已支付的订单
- (void)setCButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    
    //    // 是否支持物流查询C
    //    if(dto.canCheckLogistics){
    
    self.snxpressQueryBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
    self.snxpressQueryBtn.hidden = NO;
    
    //    }else{
    //
    //        self.snxpressQueryBtn.hidden = YES;
    //    }
}

//M:待支付的订单
- (void)setMButtonsPosiotion:(NewOrderListDTO *)dto{
    
    if(![dto.ormOrder isEqualToString:@"11601"] &&
       ![dto.ormOrder isEqualToString:@"11701"])
    {
        
        self.payBtn.hidden = YES;
        self.cancelOrderBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
        
    }
    else
    {
        self.payBtn.hidden = YES;
        self.cancelOrderBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
        
        UIButton *button1 = nil;
        UIButton *button2 = nil;
        
        BOOL cancelOrder = [dto canCancelOrderList];
        
        //可以二次支付，展示二次支付按钮
        if (dto.canTwiceBuy) {
            
            self.payBtn.hidden = NO;
            button2 = self.payBtn;
        }
        
        //可以取消订单，展示取消订单按钮
        if (cancelOrder) {
            
            self.cancelOrderBtn.hidden = NO;
            
            if (IsNilOrNull(button2)) {
                button2 = self.cancelOrderBtn;
            }else{
                button1 = self.cancelOrderBtn;
            }
        }
        
        //可以查询物流，展示物流按钮
        if (dto.canCheckLogistics) {
            
            self.snxpressQueryBtn.hidden = NO;
            
            if (IsNilOrNull(button2)) {
                button2 = self.snxpressQueryBtn;
            }else{
                button1 = self.snxpressQueryBtn;
            }
        }
        
        button1.frame = CGRectMake(90, KOrderStatusOriginY, 100, 30);
        
        button2.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
    }
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"] ||[dto.ormOrder isEqualToString:@"11701"]))
    {
        
        
        self.snxpressQueryBtn.hidden = NO;
        
        self.snxpressQueryBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
    }
    
}

//M M1:发货处理中订单
- (void)setM1OrM2ButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"]))
    {
        
        self.snxpressQueryBtn.hidden = NO;
        
        self.snxpressQueryBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
    }
    
    
}


//X:已取消的订单
- (void)setXButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    self.orderStatusLbl.hidden = YES;
}

//R:退货成功的订单
- (void)setRButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    self.orderStatusLbl.hidden = YES;
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

- (UIButton*)payBtn
{
    if(!_payBtn)
    {
        _payBtn = [[UIButton alloc] init];
        
        [_payBtn setTitle:L(@"MyEBuy_Payment") forState:UIControlStateNormal];
        
        [_payBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"comment_btn.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_payBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        
        [self.contentView addSubview:_payBtn];
    }
    
    return _payBtn;
}

- (UIButton*)cancelOrderBtn
{
    if(!_cancelOrderBtn)
    {
        _cancelOrderBtn = [[UIButton alloc] init];
        
        [_cancelOrderBtn setTitle:L(@"Cancel") forState:UIControlStateNormal];
        
        [_cancelOrderBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"right_item_light_btn.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [self.contentView addSubview:_cancelOrderBtn];
    }
    
    return _cancelOrderBtn;
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
