//
//  TicketListCell.m
//  SuningEBuy
//
//  Created by shasha on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketListCell.h"
#import "FXLabel.h"
#import "PFOrderBasicDTO.h"
#import "PlanTicketSwitch.h"

#define Label_Width                 300
#define Label_Height                25
#define kLabel_Left                 10
#define kLabel_Font                 [UIFont systemFontOfSize:14.0]
#define kLabel_Color                RGBCOLOR(81, 81, 81)
#define kLabel_ShadowOffset         CGSizeMake(0.35, 0.5)
#define kLabel_innerShadowOffset    CGSizeMake(0.35, 0.5)

@interface TicketListCell()

@property(nonatomic,strong)UIView       *whiteBack;
@property(nonatomic,strong)FXLabel      *orderId;
@property(nonatomic,strong)FXLabel      *bookingTime;
@property(nonatomic,strong)UIImageView  *oneLine;
@property(nonatomic,strong)FXLabel      *travelLine;
@property(nonatomic,strong)FXLabel      *ticketPrice;
@property(nonatomic,strong)FXLabel      *ticketCount;
@property(nonatomic,strong)FXLabel      *insurancePrice;
@property(nonatomic,strong)UIImageView  *twoLine;


@property(nonatomic,strong)FXLabel      *totalAmount;
@property(nonatomic,strong)FXLabel      *status;
@property(nonatomic,strong)FXLabel      *totalAmountContent;
@property(nonatomic,strong)UIButton     *cancelOrderBtn;
@property(nonatomic,strong)UIButton     *repayOrderBtn;

@property(nonatomic,strong)PFOrderBasicDTO *orderBasicDTO;

@end

/*********************************************************************/


@implementation TicketListCell

@synthesize whiteBack = _whiteBack;
@synthesize orderId = _orderId;
@synthesize bookingTime = _bookingTime;
@synthesize oneLine = _oneLine;
@synthesize travelLine = _travelLine;
@synthesize ticketPrice = _ticketPrice;
@synthesize ticketCount = _ticketCount;
@synthesize insurancePrice = _insurancePrice;
@synthesize twoLine = _twoLine;

@synthesize totalAmount = _totalAmount;
@synthesize status = _status;
@synthesize totalAmountContent = _totalAmountContent;
@synthesize cancelOrderBtn = _cancelOrderBtn;
@synthesize repayOrderBtn = _repayOrderBtn;
@synthesize orderBasicDTO = _orderBasicDTO;
@synthesize delegate = _delegate;

- (id)init {
    
    self = [super init];
    
    if (self) {
    }
    return self;
}

- (void)dealloc {
    
    _delegate = nil;
    
    TT_RELEASE_SAFELY(_whiteBack);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_oneLine);
    TT_RELEASE_SAFELY(_bookingTime);
    TT_RELEASE_SAFELY(_travelLine);
    TT_RELEASE_SAFELY(_ticketPrice);
    TT_RELEASE_SAFELY(_ticketCount);
    TT_RELEASE_SAFELY(_insurancePrice);
    TT_RELEASE_SAFELY(_twoLine);
    
    
    TT_RELEASE_SAFELY(_totalAmount);
    TT_RELEASE_SAFELY(_totalAmountContent);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_cancelOrderBtn);
    TT_RELEASE_SAFELY(_repayOrderBtn);
    TT_RELEASE_SAFELY(_orderBasicDTO);
}

- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return _dateFormatter;
}

- (void)setItem:(PFOrderBasicDTO *)dto
{
    if (dto == nil) {
        return;
    }
    
    self.orderBasicDTO = dto;

    @autoreleasepool {
        //订单号
        self.orderId.text = [NSString stringWithFormat:@"%@%@", L(@"BTOrderId"),dto.ordersId];
        //预定时间
        NSString *timeStr = [[self dateFormatterClient] stringFromDate:[[self dateFormatterServer] dateFromString:dto.creatTime]];
        self.bookingTime.text = timeStr;
        //航线
        self.travelLine.text = [NSString stringWithFormat:@"%@-%@【%@】", dto.startAirportName, dto.arrivAirportName, dto.airlineType];
        //机票价格
        self.ticketPrice.text = [NSString stringWithFormat:@"￥%.2f", [dto.ticketTotalAmount floatValue]];
        //机票数量
        self.ticketCount.text = [NSString stringWithFormat:@"%@%@", L(@"BTNumber"),dto.travNum];
        //保险金额
        self.insurancePrice.text = [NSString stringWithFormat:@"%@￥%.2f",L(@"BTInsurance"),[dto.insuranceTotalAmount doubleValue]];
        //合计
        self.totalAmount.text = L(@"BTTotal");
        self.totalAmountContent.text = [NSString stringWithFormat:@"￥%.2f", [dto.totalAmount floatValue]];
        //订单状态
        self.status.text = dto.status;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    //背景白
    self.whiteBack.frame = CGRectMake(0, 20, 320, 170);
    [self.contentView sendSubviewToBack:self.whiteBack];
    //订单号
    self.orderId.frame = CGRectMake(kLabel_Left, 25, 150, Label_Height);
    //下单时间
    self.bookingTime.frame = CGRectMake(160, 25, 150, Label_Height);
    //分割线一
    self.oneLine.frame = CGRectMake(0, _orderId.bottom+4, 320, 1);
    //航线
    self.travelLine.frame = CGRectMake(kLabel_Left, self.oneLine.bottom+5, 150, Label_Height);
    //机票价格
    self.ticketPrice.frame = CGRectMake(160, self.oneLine.bottom+5, 150, Label_Height);
    //机票数量
    self.ticketCount.frame = CGRectMake(kLabel_Left, self.travelLine.bottom, Label_Width, Label_Height);
    //保险价格
    self.insurancePrice.frame = CGRectMake(kLabel_Left, self.ticketCount.bottom, 150, Label_Height);
    //分割线二
    self.twoLine.frame = CGRectMake(0, self.insurancePrice.bottom+4, 320, 1);
    //合计金额
    self.totalAmount.frame = CGRectMake(kLabel_Left, self.twoLine.bottom+5, 50, Label_Height);
    self.totalAmountContent.frame = CGRectMake(self.totalAmount.right-5, self.totalAmount.top, 120, Label_Height);
    //订单状态
    self.status.frame = CGRectMake(self.totalAmountContent.right+30, self.totalAmount.top, 105 , Label_Height);
    
    if ([PlanTicketSwitch canUserNewServer]) {
        //只有等待支付状态订单，有取消订单以及再次支付的按钮
        if (!IsStrEmpty(self.orderBasicDTO.status)&&[self.orderBasicDTO.status isEqualToString:L(@"PVWaitForPay")]) {
            
            if ([self.repayOrderBtn superview] == nil) {
                [self.contentView addSubview:self.repayOrderBtn];
            }
            if ([self.status superview] != nil) {
                [self.status removeFromSuperview];
            }
            self.repayOrderBtn.frame = CGRectMake(self.totalAmountContent.right+50, self.totalAmount.top, 80, 34);
            
        }else{
            
            if ([self.repayOrderBtn superview] != nil) {
                [self.repayOrderBtn removeFromSuperview];
            }
            
            if ([self.status superview] == nil) {
                [self.contentView addSubview:_status];
            }
        }
    }
}

- (void)cancelOrder:(id)sender{

    if ([self.delegate respondsToSelector:@selector(cancelOrder:)]) {
        [self.delegate cancelOrder:self.orderBasicDTO];
    }
}


- (void)repayOrder:(id)sender{

    if ([self.delegate respondsToSelector:@selector(repayOrder:)]) {
        [self.delegate repayOrder:self.orderBasicDTO];
    }
}

+ (CGFloat)height:(PFOrderBasicDTO *)dto
{
    
    return 190;
}

#pragma mark -
#pragma mark UIView

-(UIView *)whiteBack{
    if (!_whiteBack) {
        _whiteBack = [[UIView alloc]init];
        _whiteBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBack];
    }
    return _whiteBack;
}

- (FXLabel *)orderId
{
    if (!_orderId) 
    {
        _orderId = [[FXLabel alloc]init];
        _orderId.backgroundColor = [UIColor clearColor];
        _orderId.font = kLabel_Font;
        _orderId.textAlignment = UITextAlignmentLeft;
        _orderId.size = CGSizeMake(Label_Width, Label_Height);
        _orderId.textColor = kLabel_Color;
        [self.contentView addSubview:_orderId];
    } 
    return _orderId;
}

- (FXLabel *)travelLine
{
    if (!_travelLine) 
    {
        _travelLine = [[FXLabel alloc]init];
        _travelLine.backgroundColor = [UIColor clearColor];
        _travelLine.font = [UIFont boldSystemFontOfSize:16];
        _travelLine.textAlignment = UITextAlignmentLeft;
        _travelLine.size = CGSizeMake(Label_Width, Label_Height);
        _travelLine.textColor = kLabel_Color;
        [self.contentView addSubview:_travelLine];
    } 
    return _travelLine;
}

- (FXLabel *)ticketPrice
{
    if (!_ticketPrice)
    {
        _ticketPrice = [[FXLabel alloc]init];
        _ticketPrice.backgroundColor = [UIColor clearColor];
        _ticketPrice.font = [UIFont boldSystemFontOfSize:16];
        _ticketPrice.textAlignment = UITextAlignmentRight;
        _ticketPrice.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_ticketPrice];
    }
    return _ticketPrice;
}

- (FXLabel *)ticketCount
{
    if (!_ticketCount) 
    {
        _ticketCount = [[FXLabel alloc]init];
        _ticketCount.backgroundColor = [UIColor clearColor];
        _ticketCount.font = kLabel_Font;
        _ticketCount.textAlignment = UITextAlignmentLeft;
        _ticketCount.size = CGSizeMake(Label_Width, Label_Height);
        _ticketCount.textColor = kLabel_Color;
        [self.contentView addSubview:_ticketCount];
    } 
    return _ticketCount;
}


- (FXLabel *)insurancePrice
{
    if (!_insurancePrice)
    {
        _insurancePrice = [[FXLabel alloc]init];
        _insurancePrice.backgroundColor = [UIColor clearColor];
        _insurancePrice.font = kLabel_Font;
        _insurancePrice.textAlignment = UITextAlignmentLeft;
        _insurancePrice.size = CGSizeMake(50, Label_Height);
        _insurancePrice.textColor = kLabel_Color;
        [self.contentView addSubview:_insurancePrice];
    }
    return _insurancePrice;
}


- (FXLabel *)totalAmount
{
    if (!_totalAmount) 
    {
        _totalAmount = [[FXLabel alloc]init];
        _totalAmount.backgroundColor = [UIColor clearColor];
        _totalAmount.font = [UIFont boldSystemFontOfSize:16];
        _totalAmount.textAlignment = UITextAlignmentLeft;
        _totalAmount.size = CGSizeMake(50, Label_Height);
        _totalAmount.textColor = kLabel_Color;
        [self.contentView addSubview:_totalAmount];
    } 
    return _totalAmount;
}


- (FXLabel *)totalAmountContent
{
    if (!_totalAmountContent) 
    {
        _totalAmountContent = [[FXLabel alloc]init];
        _totalAmountContent.backgroundColor = [UIColor clearColor];
        _totalAmountContent.font = [UIFont boldSystemFontOfSize:16];
        _totalAmountContent.textAlignment = UITextAlignmentLeft;
        _totalAmountContent.size = CGSizeMake(Label_Width, Label_Height);
        _totalAmountContent.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_totalAmountContent];
    } 
    return _totalAmountContent;
}

- (FXLabel *)bookingTime
{
    if (!_bookingTime) 
    {
        _bookingTime = [[FXLabel alloc]init];
        _bookingTime.backgroundColor = [UIColor clearColor];
        _bookingTime.font = kLabel_Font;
        _bookingTime.size = CGSizeMake(Label_Width, Label_Height);
        _bookingTime.textColor = kLabel_Color;
        _bookingTime.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_bookingTime];
    } 
    return _bookingTime;
}

- (FXLabel *)status
{
    if (!_status) 
    {
        _status = [[FXLabel alloc]init];
        _status.backgroundColor = [UIColor clearColor];
        _status.font = kLabel_Font;
        _status.textAlignment = UITextAlignmentRight;
        _status.size = CGSizeMake(Label_Width, Label_Height);
        _status.textColor = kLabel_Color;
    }
    return _status;
}

- (UIButton *)cancelOrderBtn{
    //"cancelOrder"="取消订单";
    if (!_cancelOrderBtn) {
        _cancelOrderBtn = [[UIButton alloc] init];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                              forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"button_white_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        [_cancelOrderBtn setTitle:L(@"BTCancel") forState:UIControlStateNormal];
        [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_cancelOrderBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelOrderBtn;
}

- (UIButton *)repayOrderBtn{
   // "repayOrder"="支付";
    if (!_repayOrderBtn) {
        _repayOrderBtn = [[UIButton alloc] init];

        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_repayOrderBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_repayOrderBtn setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];

        [_repayOrderBtn setTitle:L(@"BTPayNow") forState:UIControlStateNormal];
        [_repayOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _repayOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_repayOrderBtn addTarget:self action:@selector(repayOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _repayOrderBtn;
}

- (UIImageView *)oneLine
{
    if (!_oneLine)
    {
        _oneLine = [[UIImageView alloc] init];
        
        _oneLine.image = [UIImage imageNamed:@"line.png"];
        
        [self.contentView addSubview:_oneLine];
    }
    return _oneLine;
}

- (UIImageView *)twoLine
{
    if (!_twoLine)
    {
        _twoLine = [[UIImageView alloc] init];
        
        _twoLine.image = [UIImage imageNamed:@"line.png"];
        
        [self.contentView addSubview:_twoLine];
    }
    return _twoLine;
}

@end
