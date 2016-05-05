//
//  OrderDetailBtnCell.m
//  SuningEBuy
//
//  Created by xmy on 10/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrderDetailBtnCell.h"

@implementation OrderDetailBtnCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        if (IOS7_OR_LATER) {
            self.backgroundColor = [UIColor whiteColor];
        }else{
            UIView *bgView = [UIView new];
            bgView.backgroundColor = [UIColor clearColor];
            self.backgroundView = bgView;
        }
        
        if(self.isAddNotifition == YES)
        {
            [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notCancelOrder) name:GB_ORDER_CANCEL_FAIL object:nil];
            
        }
        else
            
        {
            
        }
    }
    return self;
}


- (UIButton*)cancelOrderBtn
{
    if(!_cancelOrderBtn)
    {
        _cancelOrderBtn = [[UIButton alloc] init];
        
        [_cancelOrderBtn setTitle:L(@"MyEBuy_CancelOrder") forState:UIControlStateNormal];
        
        [_cancelOrderBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateHighlighted];
        [_cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateDisabled];
        
        
        [self.contentView addSubview:_cancelOrderBtn];
    }
    
    return _cancelOrderBtn;
}


- (UIButton*)returnGoodsBtn
{
    if(!_returnGoodsBtn)
    {
        _returnGoodsBtn = [[UIButton alloc] init];
        
        
        [_returnGoodsBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        [_returnGoodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _returnGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_returnGoodsBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_returnGoodsBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateHighlighted];
        [_returnGoodsBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateDisabled];
        
        _returnGoodsBtn.hidden = YES;
        [self.contentView addSubview:_returnGoodsBtn];
    }
    
    return _returnGoodsBtn;
}

- (void)setDetailBtncellInfo:(MemberOrderNamesDTO *)headDto WithOrderStatus:(NSString*)statusStr
{
    
    if(headDto == nil)
    {
        return;
    }

    self.cancelOrderBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
    BOOL canCancelOrder = headDto.merchantOrderNew ;

    if([headDto.oiStatus isEqualToString:@"C"]||
       [headDto.oiStatus isEqualToString:@"SD"]||
       [headDto.oiStatus isEqualToString:@"SOMED"]||
       [headDto.oiStatus isEqualToString:@"SC"]||
       [headDto.oiStatus isEqualToString:@"WD"]||
       ([headDto.oiStatus hasPrefix:@"M"] &&
        [headDto.ormOrder isEqualToString:@"11601"]))
    {
        if([headDto.oiStatus isEqualToString:@"C"]||
           [headDto.oiStatus isEqualToString:@"SD"]||
           [headDto.oiStatus isEqualToString:@"SOMED"]||
           [headDto.oiStatus isEqualToString:@"SC"]||
           [headDto.oiStatus isEqualToString:@"WD"])
        {
            self.returnGoodsBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
            self.returnGoodsBtn.hidden = NO;
            if(([headDto.oiStatus isEqualToString:@"C"]||
               [headDto.oiStatus isEqualToString:@"SD"]||
               [headDto.oiStatus isEqualToString:@"SOMED"]||
               [headDto.oiStatus isEqualToString:@"SC"]||
               [headDto.oiStatus isEqualToString:@"WD"]) &&
               ![headDto.ormOrder isEqualToString:@"11601"])
            {
                [self.returnGoodsBtn setTitle:L(@"MyEBuy_RequestToReturn") forState:UIControlStateNormal];
                
            }
            else
            {
                if ([headDto.oiStatus isEqualToString:@"SC"]) {
                    [self.returnGoodsBtn setTitle:L(@"MyEBuy_RequestToReturn") forState:UIControlStateNormal];
                }
                else
                {
                    [self.returnGoodsBtn setTitle:L(@"BTOrderCancel") forState:UIControlStateNormal];

                }

//                [self.returnGoodsBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                
            }

        }
        else
        {
            if(canCancelOrder == YES)
            {
                self.returnGoodsBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
                self.returnGoodsBtn.hidden = NO;
                if([headDto.oiStatus isEqualToString:@"C"]||
                   [headDto.oiStatus isEqualToString:@"SD"]||
                   [headDto.oiStatus isEqualToString:@"SOMED"]||
                   [headDto.oiStatus isEqualToString:@"SC"]||
                   [headDto.oiStatus isEqualToString:@"WD"])
                {
                    [self.returnGoodsBtn setTitle:L(@"MyEBuy_RequestToReturn") forState:UIControlStateNormal];
                    
                }
                else
                {
                    [self.returnGoodsBtn setTitle:L(@"BTOrderCancel") forState:UIControlStateNormal];
                    
                }
                
            }
            else
            {
                self.returnGoodsBtn.hidden = YES;
            }
    
        }
        self.cancelOrderBtn.hidden = YES;

    }
    else
    {
        self.returnGoodsBtn.hidden = YES;

        
        if(canCancelOrder == YES)
        {
            self.cancelOrderBtn.hidden = NO;
        }
        else
        {
            self.cancelOrderBtn.hidden = YES;
            
        }
    }
    
    //如果canReturnOrder，merchantOrderNew两个字段都是0就隐藏退货或者取消订单按钮
    if ([headDto.canReturnOrder eq:@"0"] && headDto.merchantOrderNew == NO) {
        self.cancelOrderBtn.hidden = YES;
        self.returnGoodsBtn.hidden = YES;
    }
}

+ (CGFloat)setDetailBtncellInfoHeight:(MemberOrderNamesDTO *)headDto
{
    BOOL canCancelOrder = headDto.merchantOrderNew ;

    if(IsNilOrNull(headDto) || canCancelOrder == NO)
    {
        return 0;
    }
    
    return 40;
    
}
#pragma mark -
#pragma 退货申请 /选择快递
- (void)setReturnBtncellInfo
{
    [self.cancelOrderBtn setTitle:L(@"MyEBuy_SubmitApplications") forState:UIControlStateNormal];
    self.cancelOrderBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
    self.cancelOrderBtn.hidden = NO;

    UIImage *buttonImageNormal = [UIImage imageNamed:@"button_orange_normal.png"];
    
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    [self.cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                               forState:UIControlStateNormal];
    
    [self.cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"]
                               forState:UIControlStateHighlighted];
    [self.cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                               forState:UIControlStateDisabled];
}

#pragma mark - 生活团购订单列表
- (UIButton*)refundBtn
{
    if(!_refundBtn)
    {
        _refundBtn = [[UIButton alloc] init];
        
        [_refundBtn setTitle:L(@"MyEBuy_ApplyForRefund") forState:UIControlStateNormal];
        
        [_refundBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        [_refundBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _refundBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_refundBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_refundBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateHighlighted];
        [_refundBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateDisabled];
        
        _refundBtn.enabled = YES;
        
        [self.contentView addSubview:_refundBtn];
    }
    
    return _refundBtn;
}

- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return ;
    }
    self.refundBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;

    if (dto.orderStatus == 0 || [dto.statusName isEqualToString:L(@"MyEBuy_WaitingForPay2")]) {
        [self.cancelOrderBtn setTitle:L(@"BTOrderCancel") forState:UIControlStateNormal];
        self.cancelOrderBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
        self.cancelOrderBtn.hidden = NO;
    }
    else if (dto.orderStatus == 1 || [dto.statusName isEqualToString:L(@"MyEBuy_PaymentCompleted")]) {
        self.refundBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
        self.refundBtn.hidden = NO;
    }
    else
    {
        self.cancelOrderBtn.hidden = YES;

    }
    
//    if(dto.canRefund == YES && dto.orderStatus == 1)
//    {
//        self.refundBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
//        self.refundBtn.hidden = NO;
//    }
//    else
//    {
//        self.refundBtn.hidden = YES;
//    }
}
- (void)notCancelOrder
{
    [self.cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
}

- (void)setGroupRefundCell:(ReFundInfoDto *)dto
{
    if(IsNilOrNull(dto))
    {
        return ;
    }
    self.refundBtn.hidden = YES;
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"button_orange_normal.png"];
    
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    [self.cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                          forState:UIControlStateNormal];
    
    [self.cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_click.png"]
                          forState:UIControlStateHighlighted];
    [self.cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_click.png"]
                          forState:UIControlStateDisabled];
    

    [self.cancelOrderBtn setTitle:L(@"MyEBuy_SubmitApplications") forState:UIControlStateNormal];
    [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelOrderBtn.frame = CGRectMake(KNewCellOrigionX, 0, 290, 40);
    self.cancelOrderBtn.hidden = NO;
   
}


@end
