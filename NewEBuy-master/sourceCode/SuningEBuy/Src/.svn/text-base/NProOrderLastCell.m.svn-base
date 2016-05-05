//
//  NProOrderLastCell.m
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProOrderLastCell.h"
#import "orderHttpDataSource.h"

@implementation NProOrderLastCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRGBHex:0x31313131];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor orange_Red_Color];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
    
}

- (UILabel*)countLbl
{
    if(!_countLbl)
    {
        _countLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_countLbl];
        
        [self.contentView addSubview:_countLbl];
    }
    
    return _countLbl;
}

-(UILabel *)priceLbl{
    
    if (!_priceLbl) {
        
        _priceLbl = [[UILabel alloc]init];
        
        [self setContextLblProtery:_priceLbl];
        
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}


- (UILabel*)orderStatusLbl
{
    if(!_orderStatusLbl)
    {
        _orderStatusLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_orderStatusLbl];
        
        _orderStatusLbl.textColor = [UIColor dark_Gray_Color];
        
        [self.contentView addSubview:_orderStatusLbl];
    }
    return _orderStatusLbl;
}

#pragma mark -
#pragma 商品订单列表
- (void)setNProOrderLastCellInfo:(NewOrderListDTO*)dto
                      productDto:(ProductListDTO *)productDto

{
    
    if(dto == nil || productDto == nil)
    {
        return;
    }
    
    self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_Total")];
    
    self.countLbl.frame = CGRectMake(15, 5, 40, 40);
    
    self.priceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.prepayAmount doubleValue]];
    
    self.priceLbl.frame = CGRectMake(self.countLbl.right, 5, 100, 40);
    
    self.orderStatusLbl.frame = CGRectMake(250,5, 80, 40);
    self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:dto.ormOrder WithOrderStatus:dto.oiStatus];
    
    [self setAButtonsPosiotion:dto WithProduct:productDto];

    //正在支付中定单无取消与支付按钮
    if ([dto.oiStatus hasPrefix:@"M2"]  ||
        [dto.oiStatus isEqualToString:@"M3"]) {
        
        self.cancelOrderBtn.hidden = YES;
        self.payBtn.hidden = YES;
        self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:dto.ormOrder WithOrderStatus:dto.oiStatus];
        self.orderStatusLbl.frame = CGRectMake(250,5, 80, 40);
        self.orderStatusLbl.hidden = NO;
	}
}

//A:全部订单
- (void)setAButtonsPosiotion:(NewOrderListDTO *)dto
                 WithProduct:(ProductListDTO *)productDto
{
    
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
    {//已退货订单
        [self setRButtonsPosiotion:dto];
        
    }
    else
    {
        if(isDelivery == YES)
        {
            [self setCButtonsPosiotion:dto];
        }
        else if(isFinishAccept == YES)
        {
            
            [self setCButtonsPosiotion:dto];
            
        }
        else if(([dto.oiStatus eq:@"C"] ||
                 [dto.oiStatus eq:@"c"] ||
                 [dto.oiStatus eq:@"D"] ||
                 [dto.oiStatus eq:@"E"] ||
                 [dto.oiStatus eq:@"SOMED"] ||
                 [dto.oiStatus eq:@"SD"] ||
                 [dto.oiStatus eq:@"SC"] ||
                 [dto.oiStatus eq:@"WD"] ||
                 [dto.oiStatus eq:@"F"]) &&
                (isFinishAccept == NO && isDelivery == NO) )
        {//支付完成订单，已发货订单，收货完成订单
            [self setCButtonsPosiotion:dto];
        }
    }
    
    
    
}


//C:已支付的订单
- (void)setCButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.orderStatusLbl.hidden = NO;

}

//M:待支付的订单
- (void)setMButtonsPosiotion:(NewOrderListDTO *)dto{
    
//    if(![dto.ormOrder isEqualToString:@"11601"] &&
//       ![dto.ormOrder isEqualToString:@"11701"])
//    {
//        
//        self.payBtn.hidden = YES;
//        self.cancelOrderBtn.hidden = YES;
//    }
//    else
//    {
        self.payBtn.hidden = YES;
        self.cancelOrderBtn.hidden = YES;
    self.orderStatusLbl.hidden = NO;

    
        UIButton *button1 = nil;
        UIButton *button2 = nil;
        
        BOOL cancelOrder = [dto canCancelOrderList];
        
        //可以二次支付，展示二次支付按钮
        if (dto.canTwiceBuy) {
            
            self.payBtn.hidden = NO;
            button2 = self.payBtn;
            self.orderStatusLbl.hidden = YES;

        }
        
        //可以取消订单，展示取消订单按钮
        if (cancelOrder) {
            
            self.cancelOrderBtn.hidden = NO;
            
            if (IsNilOrNull(button2)) {
                button2 = self.cancelOrderBtn;
            }else{
                button1 = self.cancelOrderBtn;
            }
            
            self.orderStatusLbl.hidden = YES;

        }
        
        
        button1.frame = CGRectMake(190, 7.5, 50, 35);
        
        button2.frame = CGRectMake(254, 7.5, 50, 35);
        
//    }
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"] ||[dto.ormOrder isEqualToString:@"11701"]))
    {
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
        
        self.orderStatusLbl.hidden = NO;

    }
    
}

//M M1:发货处理中订单
- (void)setM1OrM2ButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.orderStatusLbl.hidden = NO;

    
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"]))
    {
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;

    }
    
   

}


//X:已取消的订单
- (void)setXButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.orderStatusLbl.hidden = NO;

}

//R:退货成功的订单
- (void)setRButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.orderStatusLbl.hidden = NO;
}



- (UIButton*)payBtn
{
    if(!_payBtn)
    {
        _payBtn = [[UIButton alloc] init];
        
        [_payBtn setTitle:L(@"MyEBuy_Payment") forState:UIControlStateNormal];
        
        [_payBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
//        UIImage *buttonImageNormal = [UIImage imageNamed:@"order_Orange.png"];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"submit_button_normal.png"];

        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_payBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_touched.png"]
                           forState:UIControlStateHighlighted];
        _payBtn.hidden = YES;
        
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
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateHighlighted];
        _cancelOrderBtn.hidden = YES;
        
        [self.contentView addSubview:_cancelOrderBtn];
    }
    
    return _cancelOrderBtn;
}

#pragma mark -
#pragma 门店订单列表
- (void)refreshShopOrderCellInfo:(ShopOrderListDto*)listDto
                      productDto:(ShopOrderItemListDto *)productDto
{
    
    if(listDto == nil || productDto == nil)
    {
        return;
    }

    self.orderStatusLbl.hidden = NO;

    self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_Total")];
    
    self.countLbl.frame = CGRectMake(15, 5, 40, 40);
    
    self.priceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[listDto.orderSaleAmount doubleValue]];
    
    self.priceLbl.frame = CGRectMake(self.countLbl.right, 5, 100, 40);
    
    self.orderStatusLbl.frame = CGRectMake(250, 5, 80, 40);
    self.orderStatusLbl.text = [orderHttpDataSource setOrderStatus:productDto.orderItemStatus];
    
}
#pragma mark - 生活团购订单列表
- (void)setGroupOrderListCell:(GBOrderInfoDTO *)dto 
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.countLbl.font = [UIFont systemFontOfSize:15];
    self.priceLbl.font = [UIFont systemFontOfSize:15];

    self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_Total")];
    
    self.countLbl.frame = CGRectMake(15, 5, 50, 40);
    
    self.priceLbl.text = [NSString stringWithFormat:@"¥%.2f",[dto.orderAmount doubleValue]];
    
    self.priceLbl.frame = CGRectMake(self.countLbl.right, 5, 100, 40);
    
    self.orderStatusLbl.frame = CGRectMake(250,5, 80, 40);
    self.orderStatusLbl.text = dto.statusName;
    
    if([dto.statusName isEqualToString:L(@"PVWaitForPay")])
    {
        self.payBtn.hidden = NO;
        
        self.payBtn.frame = CGRectMake(KSecondBigBtnsX, 7.5 , KNewBtnsWidth, KNewBtnsHeight);
        
        [self.payBtn setTitle:L(@"MyEBuy_Payment") forState:UIControlStateNormal];
        
        
    }
    else
    {
        self.payBtn.hidden = YES;
    }
    

}

#pragma mark -生活团购商家信息
- (void)setGroupShopInfo:(GBShopDTO *)item WithRow:(int)row
{
    if(IsNilOrNull(item))
    {
        return;
    }
    
    self.countLbl.font = [UIFont systemFontOfSize:15];
    self.priceLbl.font = [UIFont systemFontOfSize:15];
    
    self.priceLbl.textColor = [UIColor light_Black_Color];
    
    self.countLbl.frame = CGRectMake(15, 0, 50, 40);
    self.priceLbl.frame = CGRectMake(self.countLbl.right, 5, 100, 40);
    

    self.orderStatusLbl.hidden = YES;
    self.lineView.hidden = NO;

    float strHeight = 0;
    
    switch (row) {
        case 0:
        {
            strHeight = [self MaxlblNumberOfLines:[UIFont systemFontOfSize:15] WithLbl:item.name WithLblWidth:290];

            self.countLbl.text = item.name;
            self.priceLbl.hidden = YES;
            self.countLbl.frame = CGRectMake(15, 0, 290, strHeight);
        }
            break;
            
        case 1:
        {
            strHeight = [self MaxlblNumberOfLines:[UIFont systemFontOfSize:15] WithLbl:item.address WithLblWidth:240];

            self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_Address")];
            self.priceLbl.text = item.address;
            self.priceLbl.frame = CGRectMake(self.countLbl.right, 0, 240, strHeight);


        }
            break;
            
        case 2:
        {
            strHeight = [self MaxlblNumberOfLines:[UIFont systemFontOfSize:15] WithLbl:item.address WithLblWidth:140];

            self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_Telephone")];
            self.priceLbl.text = item.tel;
            self.priceLbl.frame = CGRectMake(self.countLbl.right, 0, 140, strHeight);

            self.payBtn.hidden = NO;
            [self.payBtn setBackgroundImage:[UIImage imageNamed:@"telephone-orange.png"] forState:UIControlStateNormal];
            self.payBtn.frame = CGRectMake(280, 9 , 22, 22);
            [_payBtn setBackgroundImage:[UIImage imageNamed:@"telephone-orange.png"] forState:UIControlStateHighlighted];
            [self.payBtn setTitle:@"" forState:UIControlStateNormal];
            self.lineView.hidden = YES;
            
        }
            break;
            
        default:
            break;
    }
    
    self.lineView.frame = CGRectMake(15, self.countLbl.bottom-0.5, 305, 0.5);

   

}

+ (CGFloat)setGroupShopInfoCellHeight:(GBShopDTO *)item WithRow:(int)row
{
    
    float strHeight = 0;
    switch (row) {
        case 0:
        {
          strHeight = [[NProOrderLastCell alloc] MaxlblNumberOfLines:[UIFont systemFontOfSize:15] WithLbl:item.name WithLblWidth:290];
            

        }
            break;
            
        case 1:
        {
            strHeight = [[NProOrderLastCell alloc] MaxlblNumberOfLines:[UIFont systemFontOfSize:15] WithLbl:item.address WithLblWidth:240];

        }
            break;
            
        case 2:
        {
            strHeight = [[NProOrderLastCell alloc] MaxlblNumberOfLines:[UIFont systemFontOfSize:15] WithLbl:item.tel WithLblWidth:140];
        }
            break;
            
        default:
            break;
    }
    
    return strHeight;
}


#pragma mark - 退货申请
- (void)setReturnGoodsInfo:(NSString *)str
{
    self.countLbl.font = [UIFont systemFontOfSize:16];
    self.countLbl.frame = CGRectMake(15, 0, 290, 40);
    self.countLbl.textAlignment = UITextAlignmentLeft;
    self.countLbl.text = str;
    
}

#pragma mark - 退货中
- (void)setReturnGoodsQueryInfo:(ReturnGoodsQueryDTO *)queryDto
{
    self.countLbl.font = [UIFont systemFontOfSize:16];
    self.countLbl.textAlignment = UITextAlignmentLeft;
//     NSString *str = [NSString stringWithFormat:@"服务类型: %@",queryDto.serviceType?queryDto.serviceType:@""];
    
    ReturnGoodsStatusDTO *statusDto = [queryDto.detailList lastObject];
    
    
    NSString *str = [NSString stringWithFormat:@"%@",statusDto.returnRecord?statusDto.returnRecord:@""];

    self.countLbl.text = str;
//    self.countLbl.numberOfLines = 1;
//    self.countLbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    if([queryDto.returnGoodsFlag isEqualToString:@"1"])
    {
        self.payBtn.hidden = NO;
        [self.payBtn setTitle:L(@"MyEBuy_SelectExpress") forState:UIControlStateNormal];
        
//        CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(KSecondBigBtnsX-10, MAXFLOAT)];
        
        self.countLbl.frame = CGRectMake(15, 10, KSecondBigBtnsX-10, 40);
        self.payBtn.frame = CGRectMake(KSecondBigBtnsX, 7.5, KNewBtnsWidth, KNewBtnsHeight);

    }
    else
    {
        
//        CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(290, MAXFLOAT)];
        
        self.countLbl.frame = CGRectMake(15, 10, 290, 40);

        self.payBtn.hidden = YES;
    }

}

+ (CGFloat)setReturnGoodsQueryInfoHeight:(ReturnGoodsQueryDTO *)queryDto
{
    if(IsNilOrNull(queryDto))
    {
        return 0;
    }
    
    return 40;
//    ReturnGoodsStatusDTO *statusDto = [queryDto.detailList lastObject];
//
//    NSString *str = [NSString stringWithFormat:@"%@",statusDto.returnRecord?statusDto.returnRecord:@""];
//
//    if([queryDto.returnGoodsFlag isEqualToString:@"1"])
//    {
//        CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(KSecondBigBtnsX-10, MAXFLOAT)];
//        return (sizeStr.height+20)>40?(sizeStr.height+20):40;
//
//    }
//    else
//    {
//        CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(290, MAXFLOAT)];
//
//        return (sizeStr.height+20)>40?(sizeStr.height+20):40;
//    }
}



#pragma mark - 选择快递
- (void)setReturnGoodsExpressInfo:(ReturnGoodsQueryDTO *)queryDto WithRow:(int)row
{
    if(IsNilOrNull(queryDto))
    {
        return;
    }
    
    self.priceLbl.hidden = YES;
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.orderStatusLbl.hidden = YES;
    self.countLbl.font = [UIFont systemFontOfSize:16];
    self.countLbl.textAlignment = UITextAlignmentLeft;
    self.countLbl.frame = CGRectMake(15, 10, 290, 20);
    self.lineView.hidden = NO;

    switch (row) {
        case 0:
        {
            if(IsStrEmpty(queryDto.address))
            {
                self.countLbl.hidden = YES;
                self.lineView.hidden = YES;

            }
            else
            {
                self.countLbl.hidden = NO;
                self.countLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_ReturnAddress")];
                self.countLbl.frame = CGRectMake(15, 10, 80, 20);

            }
            
            self.priceLbl.text = queryDto.address?queryDto.address:@"";
            self.priceLbl.hidden = NO;
            self.priceLbl.font =[UIFont systemFontOfSize:16];
            self.priceLbl.textAlignment = UITextAlignmentLeft;
            self.priceLbl.textColor = [UIColor colorWithRGBHex:0x313131];
            self.priceLbl.lineBreakMode = UILineBreakModeCharacterWrap;
            self.priceLbl.numberOfLines = 0;
            
            CGSize sizeStr = [self.priceLbl.text sizeWithFont:[UIFont systemFontOfSize:16]  constrainedToSize:CGSizeMake(210, MAXFLOAT)];
            
            self.priceLbl.frame = CGRectMake(self.countLbl.right, 10, 210, sizeStr.height);
            self.lineView.frame = CGRectMake(0, self.priceLbl.bottom+9.5, 320, 0.5);

        }
            break;
        case 1:
        {
            if(IsStrEmpty(queryDto.telephone))
            {
                self.countLbl.hidden = YES;
                self.lineView.hidden = YES;

            }
            else
            {
                self.countLbl.hidden = NO;
                self.countLbl.text = [NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_ContactWay"),queryDto.telephone?queryDto.telephone:@""];
                self.countLbl.frame = CGRectMake(15, 0, 290, 40);

            }

        }
            break;
        case 2:
        {
            if(IsStrEmpty(queryDto.receiver))
            {
                self.countLbl.hidden = YES;
                self.lineView.hidden = YES;

            }
            else
            {
                self.countLbl.hidden = NO;
                self.countLbl.text = [NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_Consignee"),queryDto.receiver?queryDto.receiver:@""];
                
            }

        }
            break;
            
        default:
            break;
    }

    
}

-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc]init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        _lineView.hidden = YES;
        
        [self.contentView addSubview:_lineView];
        
    }
    
    return _lineView;
}

+ (CGFloat)setExpressHeight:(ReturnGoodsQueryDTO *)queryDto WithRow:(int)row
{
    if(IsNilOrNull(queryDto))
    {
        return 0;
    }
    
    if(row == 0)
    {
        if(IsStrEmpty(queryDto.address))
        {
            return 0;
        }
        else
        {
            NSString *str = queryDto.address?queryDto.address:@"";
            
            CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(210, MAXFLOAT)];
            
            return (sizeStr.height+20)>40?(sizeStr.height+20):40;

        }
        
    }
    
    if(row == 1)
    {
        if(IsStrEmpty(queryDto.telephone))
        {
            return 0;
        }
        else
        {
            return 40;

            
        }
    }
   
    if(row == 2)
    {
        if(IsStrEmpty(queryDto.receiver))
        {
            return 0;
        }
        else
        {
            return 40;
            
            
        }
    }
    
    return 0;
}


@end
