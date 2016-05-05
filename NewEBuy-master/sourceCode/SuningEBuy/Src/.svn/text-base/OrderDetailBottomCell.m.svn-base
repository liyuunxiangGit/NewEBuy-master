//
//  OrderDetailBottomCell.m
//  SuningEBuy
//
//  Created by xmy on 10/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrderDetailBottomCell.h"
#import "NSAttributedString+Attributes.h"

@implementation OrderDetailBottomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -
#pragma 订单详情最下面bottomView中cell

- (OHAttributedLabel*)bottomLbl
{
    if(!_bottomLbl)
    {
        _bottomLbl = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(44, 0, 320-44-57, 20)];
        
        _bottomLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _bottomLbl.backgroundColor = [UIColor clearColor];
        
        _bottomLbl.font = [UIFont systemFontOfSize:16];
        
        _bottomLbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        _bottomLbl.userInteractionEnabled = YES;
        
        _bottomLbl.numberOfLines = 1;
        
        [self.contentView addSubview:_bottomLbl];
    }
    
    return _bottomLbl;
}

- (UIButton*)backBtn
{
    if(!_backBtn)
    {
        _backBtn = [[UIButton alloc] init];
        
        _backBtn.backgroundColor = [UIColor clearColor];
        
        _backBtn.frame = CGRectMake(0, 4, 44, 44);
        
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
        
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
                
        
        [self.contentView addSubview:_backBtn];
    }
    
    return _backBtn;
}

- (UIButton*)yiGouBtn
{
    if(!_yiGouBtn)
    {
        _yiGouBtn = [[UIButton alloc] init];
        
        _yiGouBtn.backgroundColor = [UIColor clearColor];
        
        _yiGouBtn.frame = CGRectMake(self.frame.size.width-57, 8, 57, 35);
        
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigou.png"] forState:UIControlStateNormal];
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigouDown.png"] forState:UIControlStateHighlighted];
        
        [self.contentView addSubview:_yiGouBtn];
        
    }
    
    return _yiGouBtn;
}

- (UIButton*)bottomPayBtn
{
    if(!_bottomPayBtn)
    {
        _bottomPayBtn = [[UIButton alloc] init];
        
        [_bottomPayBtn setTitle:L(@"MyEBuy_Payment") forState:UIControlStateNormal];
        
        [_bottomPayBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        _bottomPayBtn.backgroundColor = [UIColor clearColor];
    
        [_bottomPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _bottomPayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"submit_button_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_bottomPayBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        [_bottomPayBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_touched.png"]
                           forState:UIControlStateHighlighted];
        
        _bottomPayBtn.hidden = YES;
        
        [self.contentView addSubview:_bottomPayBtn];
    }
    
    return _bottomPayBtn;
}

- (void)setBottomCellInfo:(MemberOrderNamesDTO*)dto
               productDto:(MemberOrderDetailsDTO *)productDto
             WithYiGouBtn:(UIButton*)btn
{
    if(IsNilOrNull(dto) || IsNilOrNull(productDto))
    {
        return;
    }
    
    if([dto.totalPrice doubleValue] > 0)
    {
        self.bottomLbl.userInteractionEnabled = YES;
        
        NSMutableAttributedString *priceAtt = nil;
        
        NSString *priceStr =[NSString stringWithFormat:@"      %@ : ¥ %.2f",L(@"MyEBuy_Total"),[dto.prepayAmount doubleValue]];
        
        NSString *price = [NSString stringWithFormat:@"¥ %.2f",[dto.prepayAmount doubleValue]];
        
        priceAtt = [[NSMutableAttributedString alloc] initWithString:priceStr];
        [priceAtt setTextColor:[UIColor colorWithRGBHex:0x313131]];
        [priceAtt setTextColor:[UIColor orange_Red_Color] range:[priceStr rangeOfString:price]];
        [priceAtt setFont:[UIFont systemFontOfSize:16]];
        
        self.bottomLbl.attributedText = priceAtt;
        
        self.bottomLbl.hidden = NO;
        
        BOOL canSecondPay = dto.canTwiceBuyNew;
        
        if(canSecondPay == YES)
        {
            CGSize contextSize = [[priceAtt string] heightWithFont:[UIFont systemFontOfSize:16] width:174-15 linebreak:UILineBreakModeCharacterWrap];
            
            self.bottomLbl.frame = CGRectMake(123.5-contextSize.width/2, 14, 174-15, 20);
            
            self.yiGouBtn.hidden = YES;
            
            self.bottomPayBtn.frame = CGRectMake(self.bottomLbl.right, 6.5, KNewBtnsWidth, 35);//CGRectMake(self.bottomLbl.right, 10, 57, 35);
            
            self.bottomPayBtn.hidden = NO;

        }
        else
        {
            self.yiGouBtn.hidden = NO;
            
            self.bottomPayBtn.hidden = YES;
            
            CGSize contextSize = [[priceAtt string] heightWithFont:[UIFont systemFontOfSize:16] width:221 linebreak:UILineBreakModeCharacterWrap];
            
            self.bottomLbl.frame = CGRectMake(154.5-contextSize.width/2, 14, 221, 20);
            
        }

    }
    else
    {
        self.bottomLbl.hidden = YES;
        self.bottomPayBtn.hidden = YES;
    }
    
    
    if([dto.oiStatus isEqualToString:@"M2"] || [dto.oiStatus isEqualToString:@"M3"])
    {
        self.bottomPayBtn.hidden = YES;
    }
    else
    {
        
    }
    
}

- (void)setListBottomCellInfo
{
    self.countLbl.hidden = YES;
    self.payBtn.hidden = YES;
}

//门店订单详情
- (void)setShopBottomCellInfo:(ShopDetailItemDto*)dto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    if([dto.saleAmount doubleValue] > 0)
    {
        self.bottomLbl.userInteractionEnabled = YES;
        
        NSMutableAttributedString *priceAtt = nil;
        
        NSString *priceStr =[NSString stringWithFormat:@"      %@ : ¥ %.2f",L(@"MyEBuy_Total"),[dto.saleAmount doubleValue]];
        
        NSString *price = [NSString stringWithFormat:@"¥ %.2f",[dto.saleAmount doubleValue]];
        
        priceAtt = [[NSMutableAttributedString alloc] initWithString:priceStr];
        [priceAtt setTextColor:[UIColor colorWithRGBHex:0x313131]];
        [priceAtt setTextColor:[UIColor orange_Red_Color] range:[priceStr rangeOfString:price]];
        [priceAtt setFont:[UIFont systemFontOfSize:16]];
        
        self.bottomLbl.attributedText = priceAtt;
        
        self.bottomLbl.hidden = NO;
        
        
        CGSize contextSize = [[priceAtt string] heightWithFont:[UIFont systemFontOfSize:16] width:221 linebreak:UILineBreakModeCharacterWrap];
        
        self.bottomLbl.frame = CGRectMake(154.5-contextSize.width/2, 14, 221, 20);

    }
    else
    {
        self.bottomLbl.hidden = YES;
    }
    
    
}



//退货中列表
- (void)setReturnGoodsBottomCellInfo
{
    self.countLbl.hidden = YES;
    self.payBtn.hidden = YES;
}

- (void)setShopOrderDetailBottom
{
    
}


//生活团购订单详情
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.payBtn.hidden = YES;
    
    if([dto.orderAmount doubleValue] > 0)
    {
        self.bottomLbl.userInteractionEnabled = YES;
        
        NSMutableAttributedString *priceAtt = nil;
        
        NSString *priceStr =[NSString stringWithFormat:@"      %@ : ¥ %.2f",L(@"MyEBuy_Total"),[dto.orderAmount doubleValue]];
        
        NSString *price = [NSString stringWithFormat:@"¥ %.2f",[dto.orderAmount doubleValue]];
        
        priceAtt = [[NSMutableAttributedString alloc] initWithString:priceStr];
        [priceAtt setTextColor:[UIColor colorWithRGBHex:0x313131]];
        [priceAtt setTextColor:[UIColor colorWithRGBHex:0xff4800] range:[priceStr rangeOfString:price]];
        [priceAtt setFont:[UIFont systemFontOfSize:16]];
        
        self.bottomLbl.attributedText = priceAtt;
        
        self.bottomLbl.hidden = NO;
        
        if (dto.orderStatus == 0) {

            CGSize contextSize = [[priceAtt string] heightWithFont:[UIFont systemFontOfSize:16] width:174-15 linebreak:UILineBreakModeCharacterWrap];
            
            self.bottomLbl.frame = CGRectMake(123.5-contextSize.width/2, 14, 174-15, 20);
            
            self.yiGouBtn.hidden = YES;
            
            self.bottomPayBtn.frame = CGRectMake(self.bottomLbl.right, 6.5, KNewBtnsWidth, 35);
            
            self.bottomPayBtn.hidden = NO;
            
        }
        else
        {
            self.yiGouBtn.hidden = NO;
            
            self.bottomPayBtn.hidden = YES;
            
            CGSize contextSize = [[priceAtt string] heightWithFont:[UIFont systemFontOfSize:16] width:221 linebreak:UILineBreakModeCharacterWrap];
            
            self.bottomLbl.frame = CGRectMake(154.5-contextSize.width/2, 14, 221, 20);
            
        }
    }
    else
    {
        self.bottomLbl.hidden = YES;
        self.bottomPayBtn.hidden = YES;
    }

}


@end
