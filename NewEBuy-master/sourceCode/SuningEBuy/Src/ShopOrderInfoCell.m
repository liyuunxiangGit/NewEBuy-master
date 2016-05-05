//
//  ShopOrderInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopOrderInfoCell.h"
#import "UITableViewCell+BgView.h"

@implementation ShopOrderInfoCell

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

-(void)refreshShopOrderInfoCell:(ShopOrderListDto *)dto
{
    
    if (IsNilOrNull(dto)) {
        return;
    }
    
    self.item = dto;
    
    self.orderIdLbl.frame = CGRectMake(10, 5, 250, 20);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderCode"),dto.sourceOrderId];
    
    self.updateTimeLbl.frame = CGRectMake(10, _orderIdLbl.bottom, 250, 20);
    
    if(IsStrEmpty(dto.orderDttm))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderTime"),@""];
        
    }
    else
    {
        NSString *time = [[dto.orderDttm substringFromIndex:0] substringToIndex:10];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderTime"),time];
        
        
    }
    
    self.totoaPriceLbl.frame = CGRectMake(10, _updateTimeLbl.bottom, 80, 20);
    self.totoaPriceLbl.text = [NSString stringWithFormat:@"%@：￥",L(@"MyEBuy_TotalPayment")];
    
    self.priceLbl.frame = CGRectMake(_totoaPriceLbl.right, _updateTimeLbl.bottom, 100, 20);
    self.priceLbl.text = [NSString stringWithFormat:@"%.2f", [dto.orderSaleAmount doubleValue]];
    
     
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
    [pasteBoard setString:self.item.omsOrderId];
}


@end
