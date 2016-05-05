//
//  NewOrderStatusCell.m
//  SuningEBuy
//
//  Created by xmy on 30/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewOrderStatusCell.h"
#import "orderHttpDataSource.h"

#define KOrderStatusOriginX 5
#define KOrderStatusOriginY 5


@implementation NewOrderStatusCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor blackColor] ;//[UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}

- (UILabel*)orderStatusLbl
{
    if(!_orderStatusLbl)
    {
        _orderStatusLbl = [[UILabel alloc] init];
        
        _orderStatusLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_OrderStatus")];
        
        [self setLblProtery:_orderStatusLbl];
        
        //        [self.contentView addSubview:_orderStatusLbl];
    }
    
    return _orderStatusLbl;
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

- (UIButton*)confirmBtn
{
    if(!_confirmBtn)
    {
        _confirmBtn = [[UIButton alloc] init];
        
        [_confirmBtn setTitle:L(@"MyEBuy_ConfirmReceipt") forState:UIControlStateNormal];
        
        [_confirmBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"comment_btn.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_confirmBtn setBackgroundImage:stretchableButtonImageNormal
                               forState:UIControlStateNormal];
        
        //        [self.contentView addSubview:_confirmBtn];
    }
    
    return _confirmBtn;
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
        
        //        [_snxpressQueryBtn addTarget:self action:@selector(snxpressQueryBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_snxpressQueryBtn];
    }
    
    return _snxpressQueryBtn;
}


- (UIButton*)pingJiaBtn
{
    if(!_pingJiaBtn)
    {
        _pingJiaBtn = [[UIButton alloc] init];
        
        [_pingJiaBtn setTitle:L(@"MyEBuy_Evaluate") forState:UIControlStateNormal];
        
        [_pingJiaBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_pingJiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _pingJiaBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"comment_btn.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_pingJiaBtn setBackgroundImage:stretchableButtonImageNormal
                               forState:UIControlStateNormal];
        
        [self.contentView addSubview:_pingJiaBtn];
    }
    
    return _pingJiaBtn;
}

- (UIButton*)shaiDanBtn
{
    if(!_shaiDanBtn)
    {
        _shaiDanBtn = [[UIButton alloc] init];
        
        [_shaiDanBtn setTitle:L(@"MyEBuy_DisplayOrder") forState:UIControlStateNormal];
        
        [_shaiDanBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_shaiDanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _shaiDanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"comment_btn.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_shaiDanBtn setBackgroundImage:stretchableButtonImageNormal
                               forState:UIControlStateNormal];
        
        //        [_shaiDanBtn addTarget:self action:@selector(shaiDanBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_shaiDanBtn];
    }
    
    return _shaiDanBtn;
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
        
        //        [_payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_payBtn];
    }
    
    return _payBtn;
}

- (UIButton*)cancelOrderBtn
{
    if(!_cancelOrderBtn)
    {
        _cancelOrderBtn = [[UIButton alloc] init];
        
        [_cancelOrderBtn setTitle:L(@"BTOrderCancel") forState:UIControlStateNormal];
        
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

- (void)snxpressQueryBtnAction
{
    [self.delegate snxpressQueryDelegate];
}

- (MemberOrderNamesDTO*)listDetailDto
{
    if(!_listDetailDto)
    {
        _listDetailDto = [[MemberOrderNamesDTO alloc] init];
    }
    
    return _listDetailDto;
}

- (MemberOrderDetailsDTO*)detailDto
{
    if(!_detailDto)
    {
        _detailDto = [[MemberOrderDetailsDTO alloc] init];
    }
    
    return _detailDto;
}

- (void)setNewOrderStatusWithLine:(BOOL)isLine
                       WithListSt:(NSString*)str
                    WithDetailDto:(MemberOrderNamesDTO*)statusDto
                          WithDto:(MemberOrderDetailsDTO*)detailDto


{
    self.payBtn.hidden = YES;
    self.pingJiaBtn.hidden = YES;
    self.shaiDanBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    
    self.detailDto = detailDto;
    
    self.listDetailDto = statusDto;
    
    self.orderStatusContextLbl.text = [orderHttpDataSource getOrderTypeInfo:statusDto.oiStatus WithOrderStatus:str];
    
    self.orderStatusContextLbl.frame = CGRectMake(KOrderStatusOriginX, KOrderStatusOriginY, 100, 30);
    
    
    if(isLine == YES)
    {
        self.lineView.frame = CGRectMake(10, 1, 280, 1 );
        self.lineView.hidden = NO;
        
    }
    else
    {
        self.lineView.hidden = YES;
    }
    
    //A:所有订单
    //C:已支付的订单
    //M:待支付的订单
    //X:已取消的订单
    //R:退货成功的订单
    //    F	支付成功
    //    G	退货成功
    //    H	取消订单
    
    if([str isEqualToString:@"C"] || [str isEqualToString:@"c"] || [str isEqualToString:@"F"] || [str isEqualToString:@"C000"] ||[str hasPrefix:@"C010"] || [str hasPrefix:@"C015"])
    {
        [self setCButtonsPosiotion:self.listDetailDto ];
    }
    else if([str isEqualToString:@"M"] || [str hasPrefix:@"m"])
    {
        [self setMButtonsPosiotion:self.listDetailDto WithpolicyDesc:statusDto.policyDesc?statusDto.policyDesc:@""];
    }
    else if([str isEqualToString:@"M"] && ![self.listDetailDto.ormOrder isEqualToString:@"11601"])
    {
        [self setMButtonsPosiotion:self.listDetailDto WithpolicyDesc:statusDto.policyDesc?statusDto.policyDesc:@""];
    }
    else if([str isEqualToString:@"W"])
    {
        [self setM1OrM2ButtonsPosiotion:self.listDetailDto WithpolicyDesc:statusDto.policyDesc?statusDto.policyDesc:@""];
    }

    else if([str isEqualToString:@"X"] || [str isEqualToString:@"x"] || [str isEqualToString:@"H"])
    {
        [self setXButtonsPosiotion:self.listDetailDto];
        
    }
    else if([str isEqualToString:@"R"] || [str isEqualToString:@"r"] || [str isEqualToString:@"G"])
    {
        [self setRButtonsPosiotion:self.listDetailDto];
        
    }
    else if([str isEqualToString:@"A"] || [str isEqualToString:@"M2"])
    {
        [self setAButtonsPosiotion:statusDto WithDto:detailDto];

    }
    
    if([str isEqualToString:@"H"] || [str isEqualToString:@"X"] || [str isEqualToString:@"r"] || [str isEqualToString:@"G"] || [str isEqualToString:@"R"])
    {
        self.payBtn.hidden = YES;
        self.pingJiaBtn.hidden = YES;
        self.shaiDanBtn.hidden = YES;
        self.cancelOrderBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
        self.orderStatusContextLbl.hidden = YES;
    }
    
    
    
    if ([detailDto.oiStatus isEqualToString:@"C"]) {
        if ( ![detailDto.isBundle isEqual:@"1"] && IsStrEmpty(statusDto.supplierCode)) {
            
            self.shaiDanBtn.hidden = NO;
            self.pingJiaBtn.hidden = NO;
        }
        
        self.snxpressQueryBtn.hidden = NO;
        
    }
    
}

//A:全部订单
- (void)setAButtonsPosiotion:(MemberOrderNamesDTO *)listDto  WithDto:(MemberOrderDetailsDTO*)detailDto
{
    if([listDto.oiStatus isEqualToString:@"H"] || [listDto.oiStatus isEqualToString:@"X"] || [listDto.oiStatus isEqualToString:@"r"] || [listDto.oiStatus isEqualToString:@"G"] || [listDto.oiStatus isEqualToString:@"R"])
    {
        self.payBtn.hidden = YES;
        self.pingJiaBtn.hidden = YES;
        self.shaiDanBtn.hidden = YES;
        self.cancelOrderBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
        self.orderStatusContextLbl.hidden = YES;
    }
    else
    {
        if([listDto.oiStatus isEqualToString:@"C"] || [listDto.oiStatus isEqualToString:@"c"] || [listDto.oiStatus isEqualToString:@"F"] || [listDto.oiStatus isEqualToString:@"C000"] ||[listDto.oiStatus hasPrefix:@"C010"] || [listDto.oiStatus hasPrefix:@"C015"])
        {
            [self setCButtonsPosiotion:self.listDetailDto ];
        }
        else if([listDto.oiStatus isEqualToString:@"M"] || [listDto.oiStatus hasPrefix:@"m"])
        {
            [self setMButtonsPosiotion:self.listDetailDto WithpolicyDesc:listDto.policyDesc?listDto.policyDesc:@""];
        }
        else if([listDto.oiStatus isEqualToString:@"M"] && ![self.listDetailDto.ormOrder isEqualToString:@"11601"])
        {
            [self setMButtonsPosiotion:self.listDetailDto WithpolicyDesc:listDto.policyDesc?listDto.policyDesc:@""];
        }
        else if([listDto.oiStatus isEqualToString:@"W"])
        {
            [self setM1OrM2ButtonsPosiotion:self.listDetailDto WithpolicyDesc:listDto.policyDesc?listDto.policyDesc:@""];
        }
        
        else if([listDto.oiStatus isEqualToString:@"X"] || [listDto.oiStatus isEqualToString:@"x"] || [listDto.oiStatus isEqualToString:@"H"])
        {
            [self setXButtonsPosiotion:self.listDetailDto];
            
        }
        else if([listDto.oiStatus isEqualToString:@"R"] || [listDto.oiStatus isEqualToString:@"r"] || [listDto.oiStatus isEqualToString:@"G"])
        {
            [self setRButtonsPosiotion:self.listDetailDto];
            
        }
    }
}

//M1 M2:发货处理中订单
- (void)setM1OrM2ButtonsPosiotion:(MemberOrderNamesDTO *)listDto  WithpolicyDesc:(NSString*)policyDesc
{
    
    self.payBtn.hidden = YES;
    self.pingJiaBtn.hidden = YES;
    self.shaiDanBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    
    BOOL canCancelOrder = [listDto canCancelOrder];
    BOOL canSecondPay = [listDto canSecondPay];
    
    if(canCancelOrder == YES && canSecondPay == YES)
    {
        self.cancelOrderBtn.frame = CGRectMake(90, KOrderStatusOriginY, 100, 30);
        self.payBtn.frame = CGRectMake(self.cancelOrderBtn.right+2, KOrderStatusOriginY, 100, 30);
        self.cancelOrderBtn.hidden = NO;
        self.payBtn.hidden = NO;
    }
    
    else if(canCancelOrder == YES && canSecondPay == NO)
    {
        self.cancelOrderBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        self.cancelOrderBtn.hidden = NO;
        self.payBtn.hidden = YES;
    }
    else if(canCancelOrder == NO && canSecondPay == YES)
    {
        self.payBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
        self.cancelOrderBtn.hidden = YES;
        self.payBtn.hidden = NO;
    }
    else if(canCancelOrder == NO && canSecondPay == NO)
    {
        self.cancelOrderBtn.hidden = YES;
        self.payBtn.hidden = YES;
    }
    
    
    if([listDto.oiStatus hasPrefix:@"M"] && ([policyDesc hasPrefix:L(@"MyEBuy_CashOnDelivery")]||[listDto.ormOrder isEqualToString:@"11601"]))
    {
        
        self.snxpressQueryBtn.hidden = NO;
        
        self.snxpressQueryBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
        //        self.cancelOrderBtn.frame = CGRectMake(self.snxpressQueryBtn.right+2, KOrderStatusOriginY, 100, 30);
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
    }
    
    
}



//R:退货成功的订单
- (void)setRButtonsPosiotion:(MemberOrderNamesDTO *)listDto {
    self.payBtn.hidden = YES;
    self.pingJiaBtn.hidden = YES;
    self.shaiDanBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    self.orderStatusContextLbl.hidden = YES;
    
    cellHeight = 0;
    
}

//X:已取消的订单
- (void)setXButtonsPosiotion:(MemberOrderNamesDTO *)listDto {
    self.payBtn.hidden = YES;
    self.pingJiaBtn.hidden = YES;
    self.shaiDanBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    self.orderStatusContextLbl.hidden = YES;
    
    cellHeight = 0;
    
}

//M:待支付的订单
- (void)setMButtonsPosiotion:(MemberOrderNamesDTO *)listDto  WithpolicyDesc:(NSString*)policyDesc
{
    self.payBtn.hidden = YES;
    self.pingJiaBtn.hidden = YES;
    self.shaiDanBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    
    BOOL canCancelOrder = [listDto canCancelOrder];
    BOOL canSecondPay = [listDto canSecondPay];
    
    if(canCancelOrder == YES && canSecondPay == YES)
    {
        self.cancelOrderBtn.frame = CGRectMake(90, KOrderStatusOriginY, 100, 30);
        self.payBtn.frame = CGRectMake(self.cancelOrderBtn.right+2, KOrderStatusOriginY, 100, 30);
        self.cancelOrderBtn.hidden = NO;
        self.payBtn.hidden = NO;
    }
    
    else if(canCancelOrder == YES && canSecondPay == NO)
    {
        self.cancelOrderBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        self.cancelOrderBtn.hidden = NO;
        self.payBtn.hidden = YES;
    }
    else if(canCancelOrder == NO && canSecondPay == YES)
    {
        self.payBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
        self.cancelOrderBtn.hidden = YES;
        self.payBtn.hidden = NO;
    }
    else if(canCancelOrder == NO && canSecondPay == NO)
    {
        self.cancelOrderBtn.hidden = YES;
        self.payBtn.hidden = YES;
    }
    
    
    if([listDto.oiStatus hasPrefix:@"M"] && ([policyDesc hasPrefix:L(@"MyEBuy_CashOnDelivery")]||[listDto.ormOrder isEqualToString:@"11601"]))
    {
        
        self.snxpressQueryBtn.hidden = NO;
        
        self.snxpressQueryBtn.frame = CGRectMake(192, KOrderStatusOriginY, 100, 30);
        
        //        self.cancelOrderBtn.frame = CGRectMake(self.snxpressQueryBtn.right+2, KOrderStatusOriginY, 100, 30);
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
    }
    
}

//C:已支付的订单
- (void)setCButtonsPosiotion:(MemberOrderNamesDTO *)listDto
{
    
    self.payBtn.hidden = YES;
    self.pingJiaBtn.hidden = YES;
    self.shaiDanBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    
    
    
    if ( ![_detailDto.isBundle isEqual:@"1"]) {
        
        self.snxpressQueryBtn.frame = CGRectMake(90,KOrderStatusOriginY, 100, 30);
        
        self.pingJiaBtn.hidden = NO;
        self.pingJiaBtn.frame = CGRectMake(self.snxpressQueryBtn.right+2,KOrderStatusOriginY, 48, 30);
        
        self.shaiDanBtn.hidden = NO;
        self.shaiDanBtn.frame = CGRectMake(self.pingJiaBtn.right+2,KOrderStatusOriginY, 48, 30);
        

    }
    
    else
    {
        self.snxpressQueryBtn.frame = CGRectMake(192,KOrderStatusOriginY, 100, 30);
        
        self.shaiDanBtn.hidden = YES;
        self.pingJiaBtn.hidden = YES;
    }
    self.snxpressQueryBtn.hidden = NO;
    
    if(IsStrEmpty(listDto.supplierCode))
    {
        
    }
    else
    {
        self.snxpressQueryBtn.frame = CGRectMake(192,KOrderStatusOriginY, 100, 30);
        
        self.shaiDanBtn.hidden = YES;
        self.pingJiaBtn.hidden = YES;
    }
    
}

- (CGFloat)statusNewHeight:(MemberOrderNamesDTO *)dto
{
    if([dto.oiStatus isEqualToString:@"H"] || [dto.oiStatus isEqualToString:@"X"] || [dto.oiStatus isEqualToString:@"r"] || [dto.oiStatus isEqualToString:@"G"] || [dto.oiStatus isEqualToString:@"R"])
    {
        return 0;
    }
    else
    {
        return 40;
    }
}


+ (CGFloat)orderStatusNewCellHeight:(MemberOrderNamesDTO *)dto
{
    return [[NewOrderStatusCell alloc] statusNewHeight:dto] ;
}

@end
