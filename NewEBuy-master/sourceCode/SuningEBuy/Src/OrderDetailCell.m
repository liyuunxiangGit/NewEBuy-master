//
//  OrderDetailCell.m
//  SuningEBuy
//
//  Created by xmy on 7/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrderDetailCell.h"
#import "orderHttpDataSource.h"

@implementation OrderDetailCell

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

- (UILabel*)personNameLbl
{
    if(!_personNameLbl)
    {
        _personNameLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_personNameLbl];
        
        _personNameLbl.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_personNameLbl];
    }
    
    return _personNameLbl;
}

- (UILabel*)mobileLbl
{
    if(!_mobileLbl)
    {
        _mobileLbl = [[UILabel alloc] init];
        _mobileLbl.backgroundColor = [UIColor clearColor];
        
       _mobileLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _mobileLbl.textAlignment = UITextAlignmentRight;
        _mobileLbl.numberOfLines = 0;
        
        _mobileLbl.font = [UIFont systemFontOfSize:14.0f];
        _mobileLbl.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_mobileLbl];
    }
    
    return _mobileLbl;
}

- (UILabel*)adressLbl
{
    if(!_adressLbl)
    {
        _adressLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_adressLbl];
        
        _adressLbl.font = [UIFont systemFontOfSize:16];
        
        _adressLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _adressLbl.numberOfLines = 0;
        
        _adressLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.contentView addSubview:_adressLbl];
    }
    
    return _adressLbl;
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}
- (void)setOrderDetailCellInfo:(MemberOrderDetailsDTO*)detailDto
                   WithNameDto:(MemberOrderNamesDTO*)nameDto
{
    if(detailDto == nil || nameDto == nil || IsNilOrNull(detailDto) || IsNilOrNull(nameDto))
    {
        return;
    }
    
    self.personNameLbl.text = detailDto.itemPlacerName;
    
    // xzoscar 2014/08/29 多个手机号码换行显示
    NSString *mbStr = nil;
    if (nil != detailDto.itemMobilePhone) {
        mbStr = [detailDto.itemMobilePhone stringByReplacingOccurrencesOfString:@"_" withString:@"\n"];
    }
    self.mobileLbl.text = [mbStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.adressLbl.text = detailDto.address;
    _adressLbl.font = [UIFont systemFontOfSize:16];
    _adressLbl.textColor = [UIColor colorWithRGBHex:0x313131];
    
    self.personNameLbl.frame = CGRectMake(15, 15, 140, 16);
    self.mobileLbl.frame = CGRectMake(165, 0, 140, 44);
    self.lineView.frame = CGRectMake(10, 43.5, 300, 0.5);
    
    float addressheight = [self lblNumberOfLines:[UIFont systemFontOfSize:16] WithLbl:detailDto.address WithLblWidth:290];
    
    self.adressLbl.frame = CGRectMake(15, self.lineView.bottom+15, 290, addressheight);
    
    
}

+ (CGFloat)setOrderDetailCellHeight:(MemberOrderDetailsDTO*)detailDto
{
    if(detailDto == nil || IsNilOrNull(detailDto))
    {
        return 0;
    }
    
    if(NotNilAndNull(detailDto.address) && [detailDto.address isKindOfClass:[NSString class]])
    {
        float addressheight = [[OrderDetailCell alloc] lblNumberOfLines:[UIFont systemFontOfSize:16] WithLbl:detailDto.address WithLblWidth:290];
        
        return 74+addressheight;
        
    }
    else
    {
        return 43;
    }
}


#pragma mark -
#pragma 门店订单
- (void)setShopDetailHeadCellInfo:(ShopDetailDto*)detailDto
{
    if(IsNilOrNull(detailDto))
    {
        return;
    }

    self.personNameLbl.text = detailDto.receiveName?detailDto.receiveName:@"";
    
    // xzoscar 2014/08/29 多个手机号码换行显示
    NSString *mbStr = nil;
    if (nil != detailDto.receiveMobile) {
        mbStr = [detailDto.receiveMobile stringByReplacingOccurrencesOfString:@"_" withString:@"\n"];
    }
    self.mobileLbl.text = [mbStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *addressStr = [detailDto.receiveAddress stringByReplacingOccurrencesOfString:@";" withString:@""];
    
    self.adressLbl.text = addressStr?addressStr:@"";
    
    _adressLbl.font = [UIFont systemFontOfSize:13];
    _adressLbl.textColor = [UIColor dark_Gray_Color];
    
    self.personNameLbl.frame = CGRectMake(15, 15, 140, 16);
    self.mobileLbl.frame = CGRectMake(165,.0f, 140,44.0f);
    self.lineView.frame = CGRectMake(10, 43.5, 300, 0.5);
    
    float addressheight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:addressStr WithLblWidth:290];
    
    self.adressLbl.frame = CGRectMake(15, self.lineView.bottom+15, 290, addressheight);
    
    if(!IsStrEmpty(detailDto.receiveAddress))
    {
        if(IsStrEmpty(detailDto.receiveMobile) && IsStrEmpty(detailDto.receiveName))
        {
            self.lineView.hidden = YES;
        }
        else
        {
            self.lineView.hidden = NO;
            
        }
        
    }
    else
    {
        if(IsStrEmpty(detailDto.receiveMobile) && IsStrEmpty(detailDto.receiveName))
        {
            self.lineView.hidden = YES;
        }
        else
        {
            self.lineView.hidden = NO;
            
        }
        
    }
}


+ (CGFloat)setShopOrderDetailCellHeight:(ShopDetailDto*)detailDto
{
    if(detailDto == nil || IsNilOrNull(detailDto))
    {
        return 0;
    }
    
    if(!IsStrEmpty(detailDto.receiveAddress))
    {
        NSString *addressStr = [detailDto.receiveAddress stringByReplacingOccurrencesOfString:@";" withString:@""];
        
        float addressheight = [[OrderDetailCell alloc] lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:addressStr WithLblWidth:290];
        
        if(IsStrEmpty(detailDto.receiveMobile) && IsStrEmpty(detailDto.receiveName))
        {
            return 0;
        }
        else
        {
            return 74+addressheight;

        }
        
    }
    else
    {
        if(IsStrEmpty(detailDto.receiveMobile) && IsStrEmpty(detailDto.receiveName))
        {
            return 0;
        }
        else
        {
            return 43;
 
        }

    }
    
}
@end

@implementation OrderDetailWayCell

- (UILabel*)wayLbl
{
    if(!_wayLbl)
    {
        _wayLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_wayLbl];
        
        [self.contentView addSubview:_wayLbl];
    }
    
    return _wayLbl;
}

-(UIImageView *)ercordImg{
    if (!_ercordImg) {
        _ercordImg = [[UIImageView alloc] init];
        _ercordImg.image = [UIImage imageNamed:@"icon_digndanxiangqing_erweima"];
        [self.contentView addSubview:_ercordImg];

    }
    return _ercordImg;
}
- (UILabel*)wayContextLbl
{
    if(!_wayContextLbl)
    {
        _wayContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_wayContextLbl];
        
        _wayContextLbl.textAlignment = UITextAlignmentRight;
        
        [self.contentView addSubview:_wayContextLbl];
    }
    
    return _wayContextLbl;
}

- (UILabel*)moreInvoiceInfo
{
    if(!_moreInvoiceInfo)
    {
        _moreInvoiceInfo = [[UILabel alloc] init];
        
        [self setLblProtery:_moreInvoiceInfo];
        
        _moreInvoiceInfo.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_moreInvoiceInfo];
    }
    
    return _moreInvoiceInfo;
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

-(UIImageView *)accessView{
    
    if (!_accessView) {
        
        _accessView = [[UIImageView alloc]init];
        _accessView.backgroundColor = [UIColor clearColor];
        _accessView.image = [UIImage imageNamed:@"cellDetail.png"];
        _accessView.hidden = YES;
        [self.contentView addSubview:_accessView];
    }
    return _accessView;
}


//订单详情支付方式行,发票行,订单金额行,订单号行
- (void)setOrderDetailWayCellInfo:(MemberOrderDetailsDTO *)detailDto
                      WithNameDto:(MemberOrderNamesDTO *)nameDto
              WithSectionPosition:(int)section
                 WithCellPosition:(int)row
{
    if(IsNilOrNull(detailDto) || IsNilOrNull(nameDto))
    {
        return;
    }
    
    self.wayContextLbl.hidden = NO;
    self.lineView.hidden = NO;
    self.ercordImg.hidden = YES;

    self.wayLbl.font = [UIFont systemFontOfSize:16];
    self.wayLbl.frame = CGRectMake(15, 0, 140, 40);
    self.wayContextLbl.frame = CGRectMake(135, 0, 170, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    
    switch (section) {
            /*     case 0:
             {
             self.lineView.hidden = YES;
             
             
             if(row == 0)
             {
             self.wayLbl.text = @"校验码：";
             _wayLbl.frame = CGRectMake(15, 15, 140, 14);
             self.wayLbl.font = [UIFont systemFontOfSize:14];
             
             self.wayContextLbl.text = detailDto.verificationCode?detailDto.verificationCode:@"";
             _wayContextLbl.font = [UIFont systemFontOfSize:14];
             _wayContextLbl.textColor = [UIColor colorWithRGBHex:0xfc7c26];
             _wayContextLbl.frame = CGRectMake(76, 15, 140, 14);
             _wayContextLbl.textAlignment = UITextAlignmentLeft;
             
             }
             else if(row == 1)
             {
             self.wayLbl.text = @"校验码将在商品送达当天展示,请凭校验码收货";
             self.wayContextLbl.hidden = YES;
             _wayLbl.frame = CGRectMake(15, 0, 290, 13);
             _wayLbl.font = [UIFont systemFontOfSize:13];
             _wayLbl.textColor = [UIColor dark_Gray_Color];
             }
             else
             {
             self.wayLbl.hidden = YES;
             self.wayContextLbl.hidden = YES;
             }
             }
             
             break;*/
        case 2:
        {
            self.wayLbl.textColor = [UIColor colorWithRGBHex:0x313131];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            _wayContextLbl.textColor = [UIColor dark_Gray_Color];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.lineView.hidden = NO;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_PaymentWay");
                
                self.wayContextLbl.text = nameDto.policyDesc?nameDto.policyDesc:@"";
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_DeliveryWay");
                if(IsStrEmpty(nameDto.supplierCode))
                {
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",[detailDto.currentShipModeType isEqualToString:L(@"MyEBuy_Delivery")]?L(@"MyEBuy_SuningDelivery"):L(@"MyEBuy_PickedUpInStores")];
                    if ([self.wayContextLbl.text isEqualToString:L(@"MyEBuy_PickedUpInStores")]) {
                        self.ercordImg.hidden = NO;
                        self.ercordImg.frame = CGRectMake(self.width-100, 5, 30, 30);
                    }
                }
                else
                {
                    self.wayContextLbl.text = L(@"MyEBuy_HomeDelivery");
                    
                }
                
                
            }
            else
            {
                self.wayLbl.hidden = YES;
                self.wayContextLbl.hidden = YES;
            }
        }
            break;
        case 3:
        {
            self.wayLbl.textColor = [UIColor colorWithRGBHex:0x313131];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            _wayContextLbl.textColor = [UIColor dark_Gray_Color];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_InvoiceType");
                NSString *taxTyp;
                
                if ([detailDto.taxType isEqualToString:@"0"]) {
                    taxTyp = L(@"General invoice");
                }else if ([detailDto.taxType isEqualToString:@"1"]) {
                    taxTyp = L(@"VAT invoice");
                }else if ([detailDto.taxType isEqualToString:@"2"] ){
                    taxTyp = L(@"MyEBuy_ElectronicInvoice");
                }
                else
                {
                    taxTyp = @"";
                }
                self.wayContextLbl.text = taxTyp;
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_InvoiceHeader");
                self.wayContextLbl.text = detailDto.invoice?detailDto.invoice:@"";
                
            }
            else if (row == 2)
            {
                
                //显示更多电子发票信息 点击进入下一页
                self.moreInvoiceInfo.frame = CGRectMake(15, 0, 280, 40);
                self.moreInvoiceInfo.text = L(@"MyEBuy_MoreElectronicInvoiceInformation");
                self.lineView.hidden = YES;
                
                //小箭头
                self.accessView.hidden = NO;
                self.accessView.frame = CGRectMake(self.moreInvoiceInfo.right, 12, 10, 15);
            }
            else
            {
                self.wayLbl.hidden = YES;
                self.wayContextLbl.hidden = YES;
            }
        }
            break;
        case 5:
        {
            self.wayLbl.textColor = [UIColor colorWithRGBHex:0x313131];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            _wayContextLbl.textColor = [UIColor dark_Gray_Color];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderId");
                
                self.wayContextLbl.text = nameDto.orderId?nameDto.orderId:@"";
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderTime");
                
                if(IsStrEmpty(nameDto.lastUpdate))
                {
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",@""];
                    
                }
                else
                {
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",nameDto.lastUpdate?nameDto.lastUpdate:@""];
                    
                }
                
            }
            else if(row == 2)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderStatus");
                self.wayContextLbl.text = [orderHttpDataSource getOrderTypeInfo:nil WithOrderStatus:detailDto.oiStatus];
                
            }
            else
            {
                self.wayLbl.hidden = YES;
                self.wayContextLbl.hidden = YES;
            }
        }
            break;
            
        default:
            break;
    }
}

+ (CGFloat)setOrderDetailWayCellHeight:(MemberOrderNamesDTO*)detailDto
{
    if(detailDto == nil)
    {
        return 0;
    }
    
    return 40;
}

#pragma mark -
#pragma 门店订单
- (void)setShopDetailHeadCellInfo:(ShopDetailDto*)detailDto
                      WithItemDto:(ShopDetailItemDto*)nameDto
              WithSectionPosition:(int)section
                 WithCellPosition:(int)row

{
    if(detailDto == nil || nameDto == nil)
    {
        return;
    }
    
    self.wayContextLbl.hidden = NO;
    self.lineView.hidden = NO;
    
    self.wayLbl.font = [UIFont systemFontOfSize:16];
    self.wayLbl.frame = CGRectMake(15, 0, 140, 40);
    self.wayContextLbl.frame = CGRectMake(165, 0, 140, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    
    switch (section) {
            
        case 2:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_PaymentWay");
                
                self.wayContextLbl.text = L(@"MyEBuy_StorePayment");
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_DeliveryWay");
                self.wayContextLbl.text = [ShopDetailItemDto judgeShipContition:nameDto.shipCondition?nameDto.shipCondition:@""];
                
            }
            
        }
            break;
        case 3:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_InvoiceType");
                NSString *taxTyp;
                
                if ([detailDto.invoiceType isEqualToString:@"PT"]
                    ||[detailDto.invoiceType isEqualToString:@"01"])
                {
                    taxTyp = L(@"MyEBuy_OrdinaryInvoice");
                }else if ([detailDto.invoiceType isEqualToString:@"ZZ"]
                        || [detailDto.invoiceType isEqualToString:@"02"])
                {
                    taxTyp = L(@"MyEBuy_VATinvoice");
                }else {
                    taxTyp = detailDto.invoiceType;
                }
                
                self.wayContextLbl.text = taxTyp;
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_InvoiceHeader");
                self.wayContextLbl.text = detailDto.invoiceTitle?detailDto.invoiceTitle:@"";
                
            }
            
        }
            break;
        case 4:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderId");
                
                self.wayContextLbl.text = detailDto.sourceOrderId?detailDto.sourceOrderId:@"";
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderTime");
                
                if(IsStrEmpty(detailDto.orderDttm))
                {
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",@""];
                    
                }
                else
                {
                    //                    NSString *yearStr = [nameDto.lastUpdate substringWithRange:NSMakeRange(0, 4)];
                    //                    NSString *mouthStr = [nameDto.lastUpdate substringWithRange:NSMakeRange(5, 2)];
                    //                    NSString *dayStr = [nameDto.lastUpdate substringWithRange:NSMakeRange(8, 2)];
                    
                    NSString *timeStr = @"";
                    
                    if(detailDto.orderDttm)
                    {
                        timeStr = [detailDto.orderDttm substringWithRange:NSMakeRange(0, 10)];
                        
                    }
                    
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",timeStr];
                    
                }
                
            }
            else if(row == 2)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderStatus");
                self.wayContextLbl.text = [orderHttpDataSource setOrderStatus:nameDto.orderItemStatus];
                
            }
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 生活团购订单详情
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto
            WithSectionPosition:(int)section
               WithCellPosition:(int)row
                       WithRows:(int)num

{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.wayContextLbl.hidden = NO;
    self.lineView.hidden = NO;
    
    self.wayLbl.font = [UIFont systemFontOfSize:16];
    self.wayLbl.frame = CGRectMake(15, 0, 140, 40);
    self.wayContextLbl.frame = CGRectMake(165, 0, 140, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    
    switch (section) {
            
        case 1:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            self.accessView.hidden = NO;
            self.accessView.frame = CGRectMake(300, 15, 8, 15);
            self.wayContextLbl.hidden = YES;
            
            if(num == 1)
            {
                self.wayLbl.text = L(@"LBPrompt");
                
            }
            else if(num == 2)
            {
                if (dto.gbType == 0 && (dto.orderStatus == 1 || dto.orderStatus == 2)) {
                    
                    if(row == 0)
                    {
                        self.wayLbl.text = L(@"GBDetailOfGroupCertification");
                    }
                    else if(row == 1)
                    {
                        self.wayLbl.text = L(@"LBPrompt");
                        
                    }
                    else
                    {
                        
                    }
                }
                if (dto.gbType == 1 && (dto.orderStatus !=1 && dto.orderStatus !=2)) {
                    if(row == 0)
                    {
                        self.wayLbl.text = L(@"GBProjectOfGroupBuy");
                    }
                    else if(row == 1)
                    {
                        self.wayLbl.text = L(@"GB_Shop_Info");
                        
                    }
                    else
                    {
                        
                    }
                }
                
            }
            else
            {
                if(row == 0)
                {
                    self.wayLbl.text = L(@"GBDetailOfGroupCertification");
                }
                else if(row == 1)
                {
                    self.wayLbl.text = L(@"GBProjectOfGroupBuy");
                    
                }
                else
                {
                    self.wayLbl.text = L(@"GB_Shop_Info");
                    
                }
                
            }
            
        }
            break;
        case 2:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            
            
            self.wayLbl.text = L(@"MyEBuy_ContactInformation");
            
            self.wayContextLbl.text = dto.telephone?dto.telephone:@"";
            
            
            
        }
            break;
        case 3:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderId");
                
                self.wayContextLbl.text = dto.orderId?dto.orderId:@"";
                
            }
            else if(row == 1)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderTime");
                
                if(IsStrEmpty(dto.createTime))
                {
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",@""];
                    
                }
                else
                {
                    
                    NSString *timeStr = @"";
                    
                    if(dto.createTime)
                    {
                        timeStr = [dto.createTime substringWithRange:NSMakeRange(0, 10)];
                        
                    }
                    
                    self.wayContextLbl.text = [NSString stringWithFormat:@"%@",timeStr];
                    
                }
                
            }
            else if(row == 2)
            {
                self.wayLbl.text = L(@"MyEBuy_OrderStatus");
                self.wayContextLbl.text = dto.statusName;
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

+ (NSInteger)setRowsOfSection:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return 0;
    }
    
    if (dto.gbType == 0 && (dto.orderStatus != 1 && dto.orderStatus != 2))
    {
        return 1;
        
    }
    else if ((dto.gbType == 0 &&
              (dto.orderStatus == 1 ||
               dto.orderStatus == 2)) ||
             (dto.gbType == 1&&
              ( dto.orderStatus!=1 &&
               dto.orderStatus != 2)))
    {
        return 2;
    }
    else if (dto.gbType == 1 && (dto.orderStatus ==1 || dto.orderStatus == 2))
    {
        return 3;
        
    }
    
    return 0;
}
/*
 + (CGFloat)setGroupOrderDetailCellHeight:(GBOrderInfoDTO *)dto
 WithSectionPosition:(int)section
 WithCellPosition:(int)row
 {
 if(IsNilOrNull(dto))
 {
 return 0;
 }
 
 switch (section) {
 
 case 1:
 {
 if (dto.gbType == 0 && (dto.orderStatus != 1 && dto.orderStatus != 2))
 {
 if(row == 0)
 {
 return 40;
 }
 else
 {
 
 }
 }
 else if ((dto.gbType == 0 &&
 (dto.orderStatus == 1 ||
 dto.orderStatus == 2)) ||
 (dto.gbType == 1&&
 ( dto.orderStatus!=1 &&
 dto.orderStatus != 2)))
 {
 if(row == 3)
 {
 return 0;
 }
 else
 {
 return 40;
 
 }
 }
 else if (dto.gbType == 1 && (dto.orderStatus ==1 || dto.orderStatus == 2))
 {
 return 40;
 
 }
 
 return 0;
 }
 break;
 
 
 default:
 {
 return 40;
 }
 break;
 }
 
 
 return 0;
 
 }
 */
#pragma mark - 生活团购退款
- (UIImageView*)numLineView
{
    if(!_numLineView)
    {
        _numLineView = [[UIImageView alloc] init];
        
        _numLineView.backgroundColor = [UIColor clearColor];
        
        _numLineView.frame = CGRectMake(0, 5, 0.5, 30);
        
        [_numLineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_numLineView];
    }
    
    return _numLineView;
    
}

-(UITextField *)refundAccountTF{
    
    if (!_refundAccountTF) {
        
        _refundAccountTF = [[UITextField alloc] init];
        _refundAccountTF.backgroundColor = [UIColor clearColor];
        //        _refundAccountTF.doneButtonDelegate = self;
        _refundAccountTF.delegate = self;
        _refundAccountTF.font = [UIFont systemFontOfSize:16];
        _refundAccountTF.textAlignment = UITextAlignmentLeft;
        _refundAccountTF.textColor = [UIColor dark_Gray_Color];
        _refundAccountTF.hidden = YES;
        _refundAccountTF.returnKeyType = UIReturnKeyDone;
		_refundAccountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
		_refundAccountTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _refundAccountTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _refundAccountTF.enablesReturnKeyAutomatically = YES;
    }
    
    return _refundAccountTF;
}

- (UILabel*)refundAccountLbl
{
    if(!_refundAccountLbl)
    {
        _refundAccountLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_refundAccountLbl];
        
        _refundAccountLbl.textAlignment = UITextAlignmentLeft;
        _refundAccountLbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_refundAccountLbl];
    }
    
    return _refundAccountLbl;
}

- (void)setGroupRefundDetailCell:(ReFundInfoDto *)dto
             WithSectionPosition:(int)section
                WithCellPosition:(int)row
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    self.refundInfo = dto;
    
    self.wayContextLbl.hidden = NO;
    self.lineView.hidden = NO;
    
    self.wayLbl.font = [UIFont systemFontOfSize:16];
    self.wayLbl.frame = CGRectMake(15, 0, 140, 40);
    self.wayContextLbl.frame = CGRectMake(0, 0, 290, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    self.wayContextLbl.font = [UIFont systemFontOfSize:16];
    self.numLineView.hidden = YES;
    switch (section) {
            
        case 0:
        {
            //            if(row == 0)
            //            {
            self.wayLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"LBRefundCount3")];
            self.refundAccountLbl.text = @"¥ 0.00";
            self.refundAccountLbl.textColor = [UIColor orange_Red_Color];
            self.refundAccountLbl.frame = CGRectMake(100, 0, 140, 40);
            self.refundAccountLbl.textAlignment = UITextAlignmentLeft;
            if (2 == [dto.vouncherType intValue]) {
                
                self.refundAccountLbl.text =  [NSString stringWithFormat:@"¥ %.02f",dto.price];
            }
            else{
                
                int number = [dto.orderItemIdArray count];
                
                self.refundAccountLbl.text =  [NSString stringWithFormat:@"¥ %.02f",dto.price*number];
                
            }
            //            }
            //            else if(row == 1)
            //            {
            if(([dto.vouncherType isEqualToString:@"2"]))
            {
                [self.contentView addSubview:self.refundAccountTF];
                self.contentView.userInteractionEnabled = YES;
                self.refundAccountTF.hidden = NO;
                
                self.wayContextLbl.textColor = [UIColor light_Black_Color];
                self.wayContextLbl.text = [NSString stringWithFormat:@"%@ ",L(@"MyEBuy_RefundNumber")];
                self.wayContextLbl.textAlignment = UITextAlignmentLeft;
                int max = 5;
                
                if (dto.maxCount < 5
                    && 0 < dto.maxCount) {
                    
                    max = dto.maxCount;
                }
                
                self.numLineView.hidden = NO;
                self.wayContextLbl.frame = CGRectMake(15, 40, 80, 40);
                
                self.numLineView.frame = CGRectMake(85, 45, 0.5, 30);
                
                self.refundAccountTF.frame = CGRectMake(100, 40, 140, 40);
                
                //                    self.refundAccountTF.text = @"1";
                
                self.refundAccountTF.placeholder = [NSString stringWithFormat:@"%@%d%@",L(@"MyEBuy_LessThan"),max,L(@"MyEBuy_Nnit")];//@"最多退款多少";
                
                self.refundAccountTF.textColor = [UIColor dark_Gray_Color];
                
            }
            else
            {
                self.wayContextLbl.hidden = YES;
                self.refundAccountTF.hidden = YES;
                self.lineView.hidden = YES;
            }
            
            
            //            }
            
        }
            break;
        case 1:
        {
            [self setLblProtery:_wayLbl];
            self.wayLbl.font = [UIFont systemFontOfSize:16];
            
            [self setContextLblProtery:_wayContextLbl];
            _wayContextLbl.textAlignment = UITextAlignmentRight;
            self.wayContextLbl.font = [UIFont systemFontOfSize:16];
            
            self.lineView.hidden = NO;
            
            
            if(row == 0)
            {
                self.wayLbl.text = L(@"MyEBuy_RefundWay");
                
                self.wayContextLbl.text = L(@"GBFundBackToOriginalAccount");
                self.wayContextLbl.frame = CGRectMake(0, 0, 300, 40);
                
            }
            else if(row == 1)
            {
                
            }
            
        }
            break;
            
            
        default:
            break;
    }
}

- (ReFundInfoDto*)refundInfo
{
    if(!_refundInfo)
    {
        _refundInfo = [[ReFundInfoDto alloc] init];
    }
    return _refundInfo;
}

//#pragma mark - KeyboardDoneTappedDelegate
#pragma  mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self doneTapped:self.refundAccountTF];
    
    [textField resignFirstResponder];
    return YES;
}
- (void)doneTapped:(id)sender{
    
    int maxRefund = _refundInfo.maxCount>5?5:_refundInfo.maxCount;
    if ([_refundAccountTF.text isEqualToString:@"5"]
        ||[_refundAccountTF.text isEqualToString:@"1"]
        ||[_refundAccountTF.text isEqualToString:@"2"]
        ||[_refundAccountTF.text isEqualToString:@"3"]
        ||[_refundAccountTF.text isEqualToString:@"4"]){
        
        
        int number = [_refundAccountTF.text intValue];
        
        if (number > maxRefund) {
            
            _refundAccountTF.text = @"1";
            
        }
    }
    else{
        
        _refundAccountTF.text = @"1";
        
    }
    
    
    float totalPrice = [_refundAccountTF.text intValue] * _refundInfo.price;
    
    if(totalPrice > 0)
    {
        self.refundAccountLbl.text = [NSString stringWithFormat:@"￥%0.2f",totalPrice];
        
    }
    else
    {
        self.refundAccountLbl.text = [NSString stringWithFormat:@"￥%0.2f",_refundInfo.price];
        _refundAccountTF.text = @"1";
        
    }
    
    
    self.refundInfo.refundCount = _refundAccountTF.text;
    [_refundAccountTF resignFirstResponder];
    
    //    [self reloadPrice:self.refundAccountLbl WithText:totalPrice];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *changedStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    int maxRefund = _refundInfo.maxCount>5?5:_refundInfo.maxCount;
    //    if ([changedStr isEqualToString:@"5"]
    //        ||[changedStr isEqualToString:@"1"]
    //        ||[changedStr isEqualToString:@"2"]
    //        ||[changedStr isEqualToString:@"3"]
    //        ||[changedStr isEqualToString:@"4"]){
    //
    //        int number = [changedStr intValue];
    //
    //        if (number > maxRefund) {
    //
    //            //_refundAccountTF.text = @"1";
    //            [self insertErrorMsg:L(@"Number wrong,please enter again")];
    //            return NO;
    //        }
    //
    //
    //    }
    //    else
    //    {
    //        [self insertErrorMsg:L(@"Number wrong,please enter again")];
    //        return NO;
    //    }
    
    int number = [changedStr intValue];
    
    if (number > maxRefund || (number == 0 && [changedStr length] != 0)) {
        
        //_refundAccountTF.text = @"1";
        [self insertErrorMsg:L(@"Number wrong,please enter again")];
        return NO;
    }
    
    
    
    
    float totalPrice = [changedStr intValue] * _refundInfo.price;
    
    if(totalPrice > 0)
    {
        self.refundAccountLbl.text = [NSString stringWithFormat:@"￥%0.2f",totalPrice];
        
    }
    else
    {
        self.refundAccountLbl.text = [NSString stringWithFormat:@"￥%0.2f",_refundInfo.price];
        changedStr = @"1";
    }
    //    self.refundAccountLbl.text = [NSString stringWithFormat:@"￥%0.2f",totalPrice];
    
    self.refundInfo.refundCount = changedStr;
    
    //    [self reloadPrice:self.refundAccountLbl WithText:totalPrice];
    
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self doneTapped:self.refundAccountTF];
    [self.refundAccountTF resignFirstResponder];
    
}

-(void)insertErrorMsg:(NSString *)msg{
    
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(insertErrorMsg:)]) {
        
        [_myDelegate insertErrorMsg:msg];
    }
    
    
}

- (void)reloadPrice:(UILabel*)lbl WithText:(float)priceStr
{
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(reloadPrice:WithText:)]) {
        
        [_myDelegate reloadPrice:self.refundAccountLbl WithText:priceStr];
    }
}

@end
