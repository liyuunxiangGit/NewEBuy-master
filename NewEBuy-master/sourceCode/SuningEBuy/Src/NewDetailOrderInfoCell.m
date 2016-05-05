//
//  NewDetailOrderInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 1/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewDetailOrderInfoCell.h"
#import "orderHttpDataSource.h"

#define KOrderInfoOriginX 10
#define KOrderInfoOriginY 5

#define KHeadWidth 80
#define KContextWidth 200


@implementation NewDetailOrderInfoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UILongPressGestureRecognizer *longpressGesture  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        longpressGesture.minimumPressDuration           = 0.5;
        [self addGestureRecognizer:longpressGesture];
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
    lbl.textColor = RGBCOLOR(68, 68, 68);
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = RGBCOLOR(68, 68, 68);
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
    
}

- (UILabel*)orderIdLbl
{
    if(!_orderIdLbl)
    {
        _orderIdLbl = [[UILabel alloc] init];
        
        _orderIdLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_OrderCode")];
        
        [self setLblProtery:_orderIdLbl];
        
        [self.contentView addSubview:_orderIdLbl];
    }
    
    return _orderIdLbl;
}

- (UILabel*)orderIdContextLbl
{
    if(!_orderIdContextLbl)
    {
        _orderIdContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_orderIdContextLbl];
        
        [self.contentView addSubview:_orderIdContextLbl];
    }
    
    return _orderIdContextLbl;
    
}

- (UILabel*)payLbl
{
    if(!_payLbl)
    {
        _payLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_payLbl];
        
        _payLbl.text = [NSString stringWithFormat:@"MyEBuy_TotalPayment:",L(@"MyEBuy_TotalPayment")];
        
        [self.contentView addSubview:_payLbl];
    }
    
    return _payLbl;
    
}

- (UILabel*)payContextLbl
{
    if(!_payContextLbl)
    {
        _payContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_payContextLbl];
        
        [self.contentView addSubview:_payContextLbl];
    }
    
    return _payContextLbl;
    
}

- (UILabel*)timeLbl
{
    if(!_timeLbl)
    {
        _timeLbl = [[UILabel alloc] init];
        
        _timeLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_OrderTime")];
        
        [self setLblProtery:_timeLbl];
        
        [self.contentView addSubview:_timeLbl];
    }
    
    return _timeLbl;
}

- (UILabel*)timeContextLbl
{
    if(!_timeContextLbl)
    {
        _timeContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_timeContextLbl];
        
        [self.contentView addSubview:_timeContextLbl];
    }
    
    return _timeContextLbl;
    
}

- (UILabel*)payWayLbl
{
    if(!_payWayLbl)
    {
        _payWayLbl = [[UILabel alloc] init];
        
        _payWayLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_PaymentWay")];
        
        [self setLblProtery:_payWayLbl];
        
        [self.contentView addSubview:_payWayLbl];
    }
    
    return _payWayLbl;
}

- (UILabel*)payWayContextLbl
{
    if(!_payWayContextLbl)
    {
        _payWayContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_payWayContextLbl];
        
        [self.contentView addSubview:_payWayContextLbl];
    }
    
    return _payWayContextLbl;
    
}

- (UILabel*)orderStatusLbl
{
    if(!_orderStatusLbl)
    {
        _orderStatusLbl = [[UILabel alloc] init];
        
        _orderStatusLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_OrderStatus")];
        
        [self setLblProtery:_orderStatusLbl];
        
        [self.contentView addSubview:_orderStatusLbl];
    }
    
    return _orderStatusLbl;
}

- (UILabel*)orderStatusContextLbl
{
    if(!_orderStatusContextLbl)
    {
        _orderStatusContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_orderStatusContextLbl];
        
        [self.contentView addSubview:_orderStatusContextLbl];
    }
    
    return _orderStatusContextLbl;
    
}
- (UILabel*)invoiceStyleLbl
{
    if(!_invoiceStyleLbl)
    {
        _invoiceStyleLbl = [[UILabel alloc] init];
        
        _invoiceStyleLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_InvoiceType")];
        
        [self setLblProtery:_invoiceStyleLbl];
        
        [self.contentView addSubview:_invoiceStyleLbl];
    }
    
    return _invoiceStyleLbl;
}

- (UILabel*)invoiceStyleContextLbl
{
    if(!_invoiceStyleContextLbl)
    {
        _invoiceStyleContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_invoiceStyleContextLbl];
        
        [self.contentView addSubview:_invoiceStyleContextLbl];
    }
    
    return _invoiceStyleContextLbl;
    
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


- (UILabel*)consigneeNameLbl
{
    if(!_consigneeNameLbl)
    {
        _consigneeNameLbl = [[UILabel alloc] init];
        
        _consigneeNameLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_Consignee")];
        
        [self setLblProtery:_consigneeNameLbl];
        
        [self.contentView addSubview:_consigneeNameLbl];
    }
    
    return _consigneeNameLbl;
}

- (UILabel*)consigneeNameContextLbl
{
    if(!_consigneeNameContextLbl)
    {
        _consigneeNameContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_consigneeNameContextLbl];
        
        [self.contentView addSubview:_consigneeNameContextLbl];
    }
    
    return _consigneeNameContextLbl;
    
}

- (UILabel*)consigneeMobileLbl
{
    if(!_consigneeMobileLbl)
    {
        _consigneeMobileLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_consigneeMobileLbl];
        
        [self.contentView addSubview:_consigneeMobileLbl];
    }
    
    return _consigneeMobileLbl;
    
}


- (UILabel*)addressLbl
{
    if(!_addressLbl)
    {
        _addressLbl = [[UILabel alloc] init];
        
        _addressLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_Address")];
        
        [self setLblProtery:_addressLbl];
        
        [self.contentView addSubview:_addressLbl];
    }
    
    return _addressLbl;
}

- (UILabel*)addressContextLbl
{
    if(!_addressContextLbl)
    {
        _addressContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_addressContextLbl];
        
        [self.contentView addSubview:_addressContextLbl];
    }
    
    return _addressContextLbl;
    
}

- (UILabel*)invoiceLbl
{
    if(!_invoiceLbl)
    {
        _invoiceLbl = [[UILabel alloc] init];
        
        _invoiceLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_InvoiceHeader")];
        
        [self setLblProtery:_invoiceLbl];
        
        [self.contentView addSubview:_invoiceLbl];
    }
    
    return _invoiceLbl;
}

- (UILabel*)invoiceContextLbl
{
    if(!_invoiceContextLbl)
    {
        _invoiceContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_invoiceContextLbl];
        
        [self.contentView addSubview:_invoiceContextLbl];
    }
    
    return _invoiceContextLbl;
    
}

- (UILabel*)verificationCodeLbl
{
    if(!_verificationCodeLbl)
    {
        _verificationCodeLbl = [[UILabel alloc] init];
        
        _verificationCodeLbl.text = [NSString stringWithFormat:@"%@:",L(@"LBVerificationCode")];
        
        [self setLblProtery:_verificationCodeLbl];
        
        [self.contentView addSubview:_verificationCodeLbl];
    }
    
    return _verificationCodeLbl;
}

- (UILabel*)verificationCodeContextLbl
{
    if(!_verificationCodeContextLbl)
    {
        _verificationCodeContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_verificationCodeContextLbl];
        
        [self.contentView addSubview:_verificationCodeContextLbl];
    }
    
    return _verificationCodeContextLbl;
    
}



- (void)setNewDetailOrderInfoCell:(MemberOrderDetailsDTO*)dto WithDto:(MemberOrderNamesDTO *)displayDto WithListStatus:(NSString*)statusStr
{
    self.orderIdContextLbl.text = displayDto.orderId;
    self.timeContextLbl.text = displayDto.lastUpdate;
    self.payWayContextLbl.text = displayDto.policyDesc;
//    self.orderStatusContextLbl.text = displayDto.oiStatus;
    
    NSString *taxTyp;

    if ([dto.taxType isEqualToString:@"0"]) {
        taxTyp = L(@"General invoice");
    }else if ([dto.taxType isEqualToString:@"1"]) {
        taxTyp = L(@"VAT invoice");
    }else if ([dto.taxType isEqualToString:@"5"]){
        taxTyp = L(@"NO invoice");
    }
    else {
        taxTyp = @"";
    }
    
    self.invoiceStyleContextLbl.text = [NSString stringWithFormat:@"%@",taxTyp];

//    self.invoiceStyleContextLbl.text = dto.taxType;
    self.orderStatusContextLbl.text = [orderHttpDataSource getOrderTypeInfo:dto.oiStatus WithOrderStatus:displayDto.oiStatus];
    
    NSString *payStr;
    
//    if(IsStrEmpty(displayDto.totalShipPrice) || ![displayDto.totalShipPrice doubleValue] > 0)
//    {
        payStr = [NSString stringWithFormat:@"¥ %.2f",[displayDto.prepayAmount doubleValue]];

//    }
//    else
//    {        
//        payStr = [NSString stringWithFormat:@"¥ %.2f(含%.2f运费)",[displayDto.prepayAmount doubleValue],[displayDto.totalShipPrice doubleValue]];
//
//    }
    
    self.payContextLbl.text = payStr;

    self.orderIdLbl.frame = CGRectMake(KOrderInfoOriginX,KOrderInfoOriginY, KHeadWidth, 30);
    self.orderIdContextLbl.frame = CGRectMake(self.orderIdLbl.right,KOrderInfoOriginY, KContextWidth, 30);

    self.payLbl.frame = CGRectMake(KOrderInfoOriginX,self.orderIdLbl.bottom, KHeadWidth, 30);
    self.payContextLbl.frame = CGRectMake(self.payLbl.right,self.orderIdLbl.bottom, KContextWidth, 30);
    
    self.timeLbl.frame = CGRectMake(KOrderInfoOriginX,self.payLbl.bottom, KHeadWidth, 30);
    self.timeContextLbl.frame = CGRectMake(self.timeLbl.right,self.payLbl.bottom, KContextWidth, 30);
    
    self.payWayLbl.frame = CGRectMake(KOrderInfoOriginX,self.timeLbl.bottom, KHeadWidth, 30);
    self.payWayContextLbl.frame = CGRectMake(self.payWayLbl.right,self.timeLbl.bottom, KContextWidth, 30);
    
    self.orderStatusLbl.frame = CGRectMake(KOrderInfoOriginX,self.payWayLbl.bottom, KHeadWidth, 30);
    self.orderStatusContextLbl.frame = CGRectMake(self.orderStatusLbl.right,self.payWayLbl.bottom, KContextWidth, 30);
    
    self.invoiceStyleLbl.frame = CGRectMake(KOrderInfoOriginX,self.orderStatusLbl.bottom, KHeadWidth, 30);
    self.invoiceStyleContextLbl.frame = CGRectMake(self.invoiceStyleLbl.right,self.orderStatusLbl.bottom, KContextWidth, 30);
    
    self.lineView.frame = CGRectMake(10,self.invoiceStyleLbl.bottom+5, KContextWidth+80, 1);
    
        
    if([statusStr isEqualToString:@"H"] || [statusStr isEqualToString:@"X"] || [statusStr isEqualToString:@"r"] || [statusStr isEqualToString:@"G"] || [statusStr isEqualToString:@"R"])
    {
        self.lineView.hidden = YES;
    }
    else
    {
        self.lineView.hidden = NO;
    }
    
    

}

+ (CGFloat)DetailOrderInfoNewCellHeight:(MemberOrderDetailsDTO *)dto
{
    if([dto.oiStatus isEqualToString:@"H"] || [dto.oiStatus isEqualToString:@"X"] || [dto.oiStatus isEqualToString:@"r"] || [dto.oiStatus isEqualToString:@"G"] || [dto.oiStatus isEqualToString:@"R"])
    {
        return 190;
    }
    else
    {
        return 200;

    }

}

#pragma mark ----------------------------- 拷贝

- (void)longPress
{
    [self becomeFirstResponder];
    
    UIMenuItem   *copyItem = [[UIMenuItem alloc] initWithTitle:L(@"MyEBuy_CopyOrderNumber") action:@selector(copyClicked:)];
    UIMenuController *menuControll  = [UIMenuController sharedMenuController];
    [menuControll setMenuItems:@[copyItem]];
    
    [menuControll setTargetRect:self.orderIdContextLbl.frame inView:self.contentView];
    
    [menuControll update];
    [menuControll setMenuVisible:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copyClicked:)) {
        return YES;
    }
    return NO;
}


- (void)copyClicked:(id)sender
{
    //贴入剪贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:self.orderIdContextLbl.text];
}

@end
