//
//  NOrderHeadCell.m
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NOrderHeadCell.h"
#import "UITableViewCell+BgView.h"

@implementation NOrderHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILongPressGestureRecognizer *longpressGesture  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        longpressGesture.minimumPressDuration           = 0.5;
        [self addGestureRecognizer:longpressGesture];
        
        [self setCoolBgViewWithCellPosition:CellPositionTop hasLine:NO];
    }
    return self;
}

-(void)refreshCell:(NewOrderListDTO *)dto WithIsCshop:(BOOL)isCshop
{
    
    if (IsNilOrNull(dto)) {
        return;
    }
    
    self.item = dto;
    
//    self.backgroundView = self.backView;
    
//    [self setCoolBgViewWithCellPosition:CellPositionTop hasLine:NO];
    
    self.orderIdLbl.frame = CGRectMake(10, 5, 250, 20);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderCode"),dto.orderId];
    
    self.updateTimeLbl.frame = CGRectMake(10, _orderIdLbl.bottom, 250, 20);
    
    if(IsStrEmpty(dto.lastUpdate))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderTime"),@""];

    }
    else
    {
        NSString *time = [[dto.lastUpdate substringFromIndex:0] substringToIndex:10];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderTime"),time];
        

    }
    
    self.totoaPriceLbl.frame = CGRectMake(10, _updateTimeLbl.bottom, 80, 20);
    self.totoaPriceLbl.text = [NSString stringWithFormat:@"%@：￥",L(@"MyEBuy_TotalPayment")];
    
    self.priceLbl.frame = CGRectMake(_totoaPriceLbl.right, _updateTimeLbl.bottom, 100, 20);
    self.priceLbl.text = [NSString stringWithFormat:@"%.2f", [dto.prepayAmount doubleValue]];
    
    if([dto.oiStatus hasPrefix:@"M"] &&
       ![dto.ormOrder isEqualToString:@"11601"] &&
       ![dto.ormOrder isEqualToString:@"11701"])
    {
        
//        BOOL isCanTwiceBuy = [dto canSecondPay];
        BOOL iscancelOrder = [dto canCancelOrderList];
        
        if(iscancelOrder == YES && dto.canTwiceBuy == YES)
        {
            self.cancelOrderBtn.hidden = NO;
            
            self.payBtn.hidden = NO;
            
            self.cancelOrderBtn.frame = CGRectMake(self.priceLbl.right+2,  _updateTimeLbl.bottom-20, 50, 30);
            
            self.payBtn.frame = CGRectMake(self.cancelOrderBtn.right+2,  _updateTimeLbl.bottom-20, 50, 30);

        }
        else  if(iscancelOrder == YES && dto.canTwiceBuy == NO)
        {
            self.cancelOrderBtn.hidden = NO;
            
            self.payBtn.hidden = YES;
            
            self.cancelOrderBtn.frame = CGRectMake(self.priceLbl.right+2,  _updateTimeLbl.bottom-20, 50, 30);
            
        }
        else  if(iscancelOrder == NO && dto.canTwiceBuy == NO)
        {
            self.cancelOrderBtn.hidden = YES;
            
            self.payBtn.hidden = YES;

        }
        else  if(iscancelOrder == NO && dto.canTwiceBuy == YES)
        {
            self.cancelOrderBtn.hidden = YES;
            
            self.payBtn.hidden = NO;
                        
            self.payBtn.frame = CGRectMake(self.priceLbl.right+2,  _updateTimeLbl.bottom-20, 50, 30);

        }
        
       
    }
    else
    {
        self.cancelOrderBtn.hidden = YES;
        self.payBtn.hidden = YES;
    }
    
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

#pragma mark -
#pragma mark UIView

-(UIImageView *)backView{
    
    if (!_backView) {
        
        _backView = [[UIImageView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.image = [UIImage streImageNamed:@"yellow_top@2x.png"];
    }
    return _backView;
}

-(UILabel *)orderIdLbl{
    
    if (!_orderIdLbl) {
        _orderIdLbl = [[UILabel alloc]init];
        _orderIdLbl.backgroundColor = [UIColor clearColor];
        _orderIdLbl.font = [UIFont systemFontOfSize:13];
        _orderIdLbl.textColor = RGBCOLOR(68, 68, 68);
        [self.contentView addSubview:_orderIdLbl];
    }
    return _orderIdLbl;
}

-(UILabel *)updateTimeLbl{
    
    if (!_updateTimeLbl) {
        _updateTimeLbl = [[UILabel alloc]init];
        _updateTimeLbl.backgroundColor = [UIColor clearColor];
        _updateTimeLbl.font = [UIFont systemFontOfSize:13];
        _updateTimeLbl.textColor = RGBCOLOR(68, 68, 68);
        [self.contentView addSubview:_updateTimeLbl];
    }
    return _updateTimeLbl;
}

-(UILabel *)totoaPriceLbl{
    
    if (!_totoaPriceLbl) {
        _totoaPriceLbl = [[UILabel alloc]init];
        _totoaPriceLbl.backgroundColor = [UIColor clearColor];
        _totoaPriceLbl.font = [UIFont systemFontOfSize:13];
        _totoaPriceLbl.textColor = RGBCOLOR(68, 68, 68);
        [self.contentView addSubview:_totoaPriceLbl];
    }
    return _totoaPriceLbl;
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

#pragma mark ----------------------------- 拷贝

- (void)longPress
{
    [self becomeFirstResponder];
    
    UIMenuItem   *copyItem = [[UIMenuItem alloc] initWithTitle:L(@"MyEBuy_CopyOrderNumber") action:@selector(copyClicked:)];
    UIMenuController *menuControll  = [UIMenuController sharedMenuController];
    [menuControll setMenuItems:@[copyItem]];
    
    [menuControll setTargetRect:self.orderIdLbl.frame inView:self.contentView];
    
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
    [pasteBoard setString:self.item.orderId];
}


@end
