//
//  NewOrderProInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 30/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewOrderProInfoCell.h"
#import "ProductUtil.h"
#import "orderHttpDataSource.h"

#define  KNewProOriginX 15

#define  KNewProOriginY 12

@implementation NewOrderProInfoCell

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
    lbl.textColor = RGBCOLOR(68, 68, 68);//[UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = RGBCOLOR(68, 68, 68);//[UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
}

- (UILabel*)productNameLbl
{
    if(!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_productNameLbl];
        
        _productNameLbl.font = [UIFont systemFontOfSize:13];
        
        _productNameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _productNameLbl.numberOfLines = 2;
        
        _productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        
        [self.contentView addSubview:_productNameLbl];
    }
    
    return _productNameLbl;
}

- (UILabel*)shopContextLbl
{
    if(!_shopContextLbl)
    {
        _shopContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_shopContextLbl];
        
        _shopContextLbl.textColor = RGBCOLOR(137, 137, 137);;
        _shopContextLbl.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_shopContextLbl];
    }
    
    return _shopContextLbl;
    
}


- (UILabel*)productPriceContextLbl
{
    if(!_productPriceContextLbl)
    {
        _productPriceContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_productPriceContextLbl];
        
        _productPriceContextLbl.textColor = [UIColor redColor];
        _productPriceContextLbl.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_productPriceContextLbl];
    }
    
    return _productPriceContextLbl;
}


- (UILabel*)productNumLbl
{
    if(!_productNumLbl)
    {
        _productNumLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_productNumLbl];
        
        _productNumLbl.text = [NSString stringWithFormat:@"%@:",L(@"Constant_Amount")];
        
        _productNumLbl.textColor = RGBCOLOR(137, 137, 137) ;//[UIColor blackColor];
        _productNumLbl.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_productNumLbl];
    }
    
    return _productNumLbl;
    
}

- (UILabel*)productNumContextLbl
{
    if(!_productNumContextLbl)
    {
        _productNumContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_productNumContextLbl];
        
        [self.contentView addSubview:_productNumContextLbl];
    }
    
    return _productNumContextLbl;
}



- (EGOImageView*)productImageV
{
    if(!_productImageV)
    {
        _productImageV = [[EGOImageView alloc] init];
        
        _productImageV.backgroundColor = [UIColor clearColor];
        
        _productImageV.frame = CGRectMake(5, 5, 60, 60);
        
        _productImageV.contentMode = UIViewContentModeScaleAspectFill;
        
        _productImageV.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        
        //        _productImageV.layer.masksToBounds = YES;
        //        _productImageV.layer.cornerRadius = 0.5;
        //
        _productImageV.layer.borderColor = RGBCOLOR(220, 220, 220).CGColor;
        _productImageV.layer.borderWidth = .5;
        
        
        [self.contentView addSubview:_productImageV];
    }
    
    return _productImageV;
    
}


- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (UIImageView*)lineView2
{
    if(!_lineView2)
    {
        _lineView2 = [[UIImageView alloc] init];
        
        _lineView2.backgroundColor = [UIColor clearColor];
        
        _lineView2.frame = CGRectMake(0, 5, 320, 0.5);
        
        [_lineView2 setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView2];
    }
    
    return _lineView2;
    
}

- (UIImageView*)lineView3
{
    if(!_lineView3)
    {
        _lineView3 = [[UIImageView alloc] init];
        
        _lineView3.backgroundColor = [UIColor clearColor];
        
        _lineView3.frame = CGRectMake(0, 5, 320, 0.5);
        
        [_lineView3 setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView3];
    }
    
    return _lineView3;
    
}



//- (UILabel*)orderStatusContextLbl
//{
//    if(!_orderStatusContextLbl)
//    {
//        _orderStatusContextLbl = [[UILabel alloc] init];
//
//        [self setContextLblProtery:_orderStatusContextLbl];
//
//        _orderStatusContextLbl.textColor = RGBCOLOR(137, 137, 137);
//
//        [self.contentView addSubview:_orderStatusContextLbl];
//    }
//
//    return _orderStatusContextLbl;
//
//}

- (UIButton*)confirmBtn
{
    if(!_confirmBtn)
    {
        _confirmBtn = [[UIButton alloc] init];
        _confirmBtn.frame = CGRectMake(KSecondBigBtnsX,self.productImageV.bottom + 15, KNewBtnsWidth, KNewBtnsHeight);
        //        _confirmBtn.frame = CGRectMake(90, 0, 100, 40);
        [_confirmBtn setTitle:L(@"MyEBuy_ConfirmReceipt") forState:UIControlStateNormal];
        
        [_confirmBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
        
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_confirmBtn setBackgroundImage:stretchableButtonImageNormal
                               forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                               forState:UIControlStateHighlighted];
        
        [self.contentView addSubview:_confirmBtn];
    }
    
    return _confirmBtn;
    
}


- (UIButton*)snxpressQueryBtn
{
    if(!_snxpressQueryBtn)
    {
        _snxpressQueryBtn = [[UIButton alloc] init];
        
        [_snxpressQueryBtn setTitle:L(@"MyEBuy_CheckExpress") forState:UIControlStateNormal];
        
        [_snxpressQueryBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
        
        _snxpressQueryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_snxpressQueryBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_snxpressQueryBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                     forState:UIControlStateHighlighted];
        
        [self.contentView addSubview:_snxpressQueryBtn];
    }
    
    return _snxpressQueryBtn;
}

- (UIButton*)returnGoodsBtn
{
    if(!_returnGoodsBtn)
    {
        _returnGoodsBtn = [[UIButton alloc] init];
        
        [_returnGoodsBtn setTitle:L(@"MyEBuy_RequestToReturn") forState:UIControlStateNormal];
        
        [_returnGoodsBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
        
        _returnGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_returnGoodsBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        [_returnGoodsBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                   forState:UIControlStateHighlighted];
        
        _returnGoodsBtn.hidden = YES;
        
        [self.contentView addSubview:_returnGoodsBtn];
    }
    
    return _returnGoodsBtn;
}
- (UIButton*)pingJiaBtn
{
    if(!_pingJiaBtn)
    {
        _pingJiaBtn = [[UIButton alloc] init];
        
        [_pingJiaBtn setTitle:L(@"MyEBuy_Evaluate") forState:UIControlStateNormal];
        
        [_pingJiaBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _pingJiaBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_pingJiaBtn setBackgroundImage:stretchableButtonImageNormal                           forState:UIControlStateNormal];
        [_pingJiaBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                               forState:UIControlStateHighlighted];
        
        
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
        
        [_shaiDanBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _shaiDanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_shaiDanBtn setBackgroundImage:stretchableButtonImageNormal                           forState:UIControlStateNormal];
        [_shaiDanBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                               forState:UIControlStateHighlighted];
        
        [self.contentView addSubview:_shaiDanBtn];
    }
    
    return _shaiDanBtn;
}


- (UIButton*)bothBtn
{
    if(!_bothBtn)
    {
        _bothBtn = [[UIButton alloc] init];
        
        [_bothBtn setTitle:L(@"MyEBuy_EvaluateOrDisplayOrder") forState:UIControlStateNormal];
        
        [_bothBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _bothBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_bothBtn setBackgroundImage:stretchableButtonImageNormal
                            forState:UIControlStateNormal];
        [_bothBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                            forState:UIControlStateHighlighted];
        _bothBtn.hidden = YES;
        [self.contentView addSubview:_bothBtn];
    }
    
    return _bothBtn;
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
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_payBtn setBackgroundImage:stretchableButtonImageNormal                           forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"orange_button_clicked.png"]
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
        
        [_cancelOrderBtn setTitle:L(@"BTOrderCancel") forState:UIControlStateNormal];
        
        [_cancelOrderBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"order_White.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_cancelOrderBtn setBackgroundImage:[UIImage streImageNamed:@"order_WhiteClicked.png"]
                                   forState:UIControlStateHighlighted];
        
        _cancelOrderBtn.hidden = YES;
        
        [self.contentView addSubview:_cancelOrderBtn];
    }
    
    return _cancelOrderBtn;
}

- (UIImageView*)lineTwoView
{
    if(!_lineTwoView)
    {
        _lineTwoView = [[UIImageView alloc] init];
        
        _lineTwoView.backgroundColor = [UIColor clearColor];
        
        _lineTwoView.frame = CGRectMake(0, 79, 280, 1);
        
        [_lineTwoView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineTwoView];
    }
    
    return _lineTwoView;
    
}
-(UIImageView *)accessView{
    
    if (!_accessView) {
        
        _accessView = [[UIImageView alloc]init];
        _accessView.backgroundColor = [UIColor clearColor];
        _accessView.image = [UIImage imageNamed:@"cellDetail.png"];
        [self.contentView addSubview:_accessView];
    }
    return _accessView;
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


- (UILabel*)jiaoYanMaLbl
{
    if(!_jiaoYanMaLbl)
    {
        _jiaoYanMaLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_jiaoYanMaLbl];
        
        _jiaoYanMaLbl.textColor = RGBCOLOR(137, 137, 137);;
        _jiaoYanMaLbl.font = [UIFont systemFontOfSize:12];
        _jiaoYanMaLbl.hidden = YES;
        [self.contentView addSubview:_jiaoYanMaLbl];
    }
    
    return _jiaoYanMaLbl;
    
}
#pragma mark - 商品订单详情
//订单详情界面设置,row 0为第一个 1为最后一个 2为中间 3只有一个
- (void)setDetailNewOrderProInfo:(MemberOrderDetailsDTO *)detailDto
                     WithHeadDto:(MemberOrderNamesDTO *)headDto
                    WithCodeBOOL:(BOOL)isCode
                         WithRow:(int)row
                      WithFinish:(BOOL)finishAcceptOK
                    WithDelivery:(BOOL)delivertOK
              WithIsYangGuangBao:(BOOL)isYGB
          logisticsShowReference:(NSString *)logisticsShowReference
{
    
    self.logisticsShowReference = logisticsShowReference;
    if(IsNilOrNull(detailDto) || IsNilOrNull(headDto))
    {
        return;
    }
    
    self.listDetailDto = headDto;
    self.detailDto = detailDto;
    self.row = row;
    
    if([detailDto.exWarrantyFlag isEqualToString:@"1"])
    {
        [self.productImageV setImage:[UIImage imageNamed:@"YangGuangBao.png"]];
        self.productImageV.frame = CGRectMake(KNewProOriginX, 15, 85, 36.5);
        _productImageV.layer.borderWidth = .0;
    }
    else
    {
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:detailDto.productCode size:ProductImageSize160x160];
        }
        else{
            
            self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:detailDto.productCode size:ProductImageSize120x120];
        }
        self.productImageV.frame = CGRectMake(KNewProOriginX, 15, 85, 85);
        _productImageV.layer.borderWidth = .5;
        
    }
    
    
    
    self.productNameLbl.text = detailDto.productName;
    
    
    if(IsStrEmpty(headDto.supplierCode) )
        
    {
        self.shopContextLbl.text = L(@"MyEBuy_SuningSelf");
        
    }
    else
    {
        self.shopContextLbl.text = headDto.cShopName;
        
    }
    
    self.productNumLbl.text =[NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[detailDto.quantityInIntValue intValue]] ;
    
    NSString *marketPrice = [NSString stringWithFormat:@"¥ %.2f",[detailDto.totalProduct floatValue]];
    
    self.productPriceContextLbl.text = marketPrice;
    
    
    int nameLines = [self setProNameHeight:detailDto.productName WithLbl:self.productNameLbl];
    
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.productImageV.right+10, 16, 190, 15);
        self.productPriceContextLbl.frame = CGRectMake(self.productImageV.right+10, 55, 100, 20);
        
        self.productNumLbl.frame = CGRectMake(_productPriceContextLbl.right+10, 55, 85, 20);
        
        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.productImageV.right+10, 10, 190, 40);
        self.productPriceContextLbl.frame = CGRectMake(self.productImageV.right+10, 55, 100, 20);
        
        self.productNumLbl.frame = CGRectMake(_productPriceContextLbl.right+10, 55, 85, 20);
        
    }
    
    self.accessView.frame = CGRectMake(300, 52, 8, 15);
    
    
    if(IsStrEmpty(detailDto.verificationCode) || [detailDto.verificationCode isEqualToString:@"0000"])
    {
        self.jiaoYanMaLbl.hidden = YES;
        
        self.jiaoYanMaLbl.text = @"";
        self.shopContextLbl.frame = CGRectMake(self.productImageV.right+10, _productNumLbl.bottom, 180, 20);
        
    }
    else
    {
        self.shopContextLbl.frame = CGRectMake(self.productImageV.right+10, _productNumLbl.bottom, 100, 20);
        
        self.jiaoYanMaLbl.hidden = NO;
        self.jiaoYanMaLbl.text = [NSString stringWithFormat:@"%@:%@",L(@"MyEBuy_CheckCode"),detailDto.verificationCode?detailDto.verificationCode:@""];
        
        self.jiaoYanMaLbl.frame = CGRectMake(self.shopContextLbl.right, _productNumLbl.bottom, 85, 20);
    }
    
    if([detailDto.exWarrantyFlag isEqualToString:@"1"])
    {
        self.lineView.hidden = NO;
        self.lineTwoView.hidden = YES;
        if(isYGB == YES)
        {
            self.lineView.frame = CGRectMake(15, 79.5, 305, 0.5);
            
        }
        else
        {
            self.lineView.frame = CGRectMake(0, 79.5, 320, 0.5);
            
        }
        self.shopContextLbl.hidden = YES;
        self.accessView.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
    }
    else
    {
        self.shopContextLbl.hidden = NO;
        self.accessView.hidden = NO;
        
        self.lineView.hidden = YES;
        self.lineTwoView.hidden = YES;
        if(isYGB == YES)
        {
            self.lineView.frame = CGRectMake(15, 109.5, 305, 0.5);
            self.lineTwoView.frame = CGRectMake(15, 162.5, 305, 0.5);
        }
        else
        {
            self.lineView.frame = CGRectMake(0, 109.5, 320, 0.5);
            self.lineTwoView.frame = CGRectMake(0, 162.5, 320, 0.5);
        }
        
        [self setAButtonsPosiotion:headDto WithFinish:finishAcceptOK WithDelivery:delivertOK];
        
    }
    if (self.snxpressQueryBtn.hidden == NO) {
        self.confirmBtn.frame = CGRectMake(KFirstBigBtnsX, self.productImageV.bottom + 15, KNewBtnsWidth, KNewBtnsHeight);
    }
    //    self.confirmBtn.frame = CGRectMake(KFirstBigBtnsX, self.iconImageView.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
        if (self.snxpressQueryBtn.hidden == NO) {
        self.pingJiaBtn.frame = CGRectMake(138,self.productImageV.bottom + 15, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
        self.shaiDanBtn.frame = CGRectMake(138,self.productImageV.bottom + 15, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
        self.bothBtn.frame = CGRectMake(138,self.productImageV.bottom + 15, KNewSmallBtnsWidth+ 10, KNewBtnsHeight);

    }
    else
    {
        self.pingJiaBtn.frame = CGRectMake(241,self.productImageV.bottom + 15, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
        self.shaiDanBtn.frame = CGRectMake(241,self.productImageV.bottom + 15, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
        self.bothBtn.frame = CGRectMake(241,self.productImageV.bottom + 15, KNewSmallBtnsWidth + 10, KNewBtnsHeight);

    }
    
    [self setFourButton:detailDto];
    
    if ([self.logisticsShowReference eq:@"1"] || self.payBtn.hidden == NO || self.shaiDanBtn.hidden == NO || self.bothBtn.hidden == NO)
    {
        self.lineView.frame = CGRectMake(0, 162.5, 320, 0.5);
    }

//    if (!IsStrEmpty(detailDto.commentOrNot)) {
//        if ([detailDto.commentOrNot eq:@"1"]) {
//            self.pingJiaBtn.hidden = NO;
//        }
//        else
//        {
//            self.pingJiaBtn.hidden = YES;
//        }
//        
//        
//    }
//    else
//    {
//        self.pingJiaBtn.hidden = YES;
//    }
//    if (!IsStrEmpty(detailDto.showOrNot)) {
//        if ([detailDto.showOrNot eq:@"1"]) {
//            self.shaiDanBtn.hidden = NO;
//        }
//        else
//        {
//            self.shaiDanBtn.hidden = YES;
//        }
//        
//    }
//    else
//    {
//        self.shaiDanBtn.hidden = YES;
//    }
//    
//    if (self.snxpressQueryBtn.hidden == YES) {
//        self.pingJiaBtn.frame = CGRectMake(188,self.productImageV.bottom + 155, KNewSmallBtnsWidth, KNewBtnsHeight);
//        self.shaiDanBtn.frame = CGRectMake(251,self.productImageV.bottom + 15, KNewSmallBtnsWidth, KNewBtnsHeight);
//    }
//    else
//    {
//        self.pingJiaBtn.frame = CGRectMake(85,self.productImageV.bottom + 15, KNewSmallBtnsWidth, KNewBtnsHeight);
//        self.shaiDanBtn.frame = CGRectMake(148,self.productImageV.bottom + 15, KNewSmallBtnsWidth, KNewBtnsHeight);
//    }
//    if (self.shaiDanBtn.hidden == YES) {
//        self.pingJiaBtn.frame = CGRectMake(self.shaiDanBtn.frame.origin.x,self.productImageV.bottom + 15, KNewSmallBtnsWidth, KNewBtnsHeight);
//    }
//    if (self.pingJiaBtn.hidden == NO || self.shaiDanBtn.hidden == NO) {
//        self.lineView.frame = CGRectMake(0, 162.5, 320, 0.5);
//    }
    
    
    
}

//物流 评价 晒单 评价晒单 四个按钮显示关系
- (void)setFourButton:(MemberOrderDetailsDTO *)detailDto
{
    //0显示 1不显示
    if ([detailDto.commentOrNot eq:@"1"] && [detailDto.showOrNot eq:@"1"]) {
        self.bothBtn.hidden = NO;
        self.pingJiaBtn.hidden = YES;
        self.shaiDanBtn.hidden = YES;
    }
    else if ([detailDto.commentOrNot eq:@"1"] && [detailDto.showOrNot eq:@"0"])
    {
        self.pingJiaBtn.hidden = NO;
        self.shaiDanBtn.hidden = YES;
        self.bothBtn.hidden = YES;
    }
    else if ([detailDto.commentOrNot eq:@"0"] && [detailDto.showOrNot eq:@"1"])
    {
        self.shaiDanBtn.hidden = NO;
        self.pingJiaBtn.hidden = YES;
        self.bothBtn.hidden = YES;
    }
    else
    {
        self.shaiDanBtn.hidden = YES;
        self.pingJiaBtn.hidden = YES;
        self.bothBtn.hidden = YES;
    }
}


//合约机
- (void)setSimCardInfo:(MemberOrderDetailsDTO *)detailDto
           WithHeadDto:(MemberOrderNamesDTO *)headDto
{
//    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
//        
//        self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:detailDto.productCode size:ProductImageSize160x160];
//    }
//    else{
//        
//        self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:detailDto.productCode size:ProductImageSize120x120];
//    }
    self.productImageV.imageURL = [NSURL URLWithString:detailDto.simPicPath];
    self.productImageV.frame = CGRectMake(32.5, 15, 50, 50);
    _productImageV.layer.borderWidth = .5;
    
    self.productNameLbl.frame = CGRectMake(self.productImageV.right+27.5, 20, 190, 40);
    self.productNameLbl.text = detailDto.partName;
    
    self.lineView3.frame = CGRectMake(0, 79.5, 320, 0.5);

    
}

//A订单
- (void)setAButtonsPosiotion:(MemberOrderNamesDTO *)headDto
                  WithFinish:(BOOL)finishAcceptOK
                WithDelivery:(BOOL)delivertOK
{
    self.lineView.hidden = NO;
    self.lineTwoView.hidden = YES;
    
    
    if([headDto.oiStatus hasPrefix:@"M"])
    {//等待支付订单
        
        if([headDto.ormOrder isEqualToString:@"11601"])
        {//货到付款订单
            [self setM1OrM2ButtonsPosiotion:self.listDetailDto WithpolicyDesc:headDto.policyDesc?headDto.policyDesc:@""];
            
        }
        else
        {
            [self setMButtonsPosiotion:self.listDetailDto WithpolicyDesc:headDto.policyDesc?headDto.policyDesc:@""];
            
            
        }
    }
    else if(([headDto.oiStatus eq:@"X"] ||
             [headDto.oiStatus eq:@"x"] ||
             [headDto.oiStatus eq:@"H"]))
    {//已取消订单
        [self setXButtonsPosiotion:self.listDetailDto];
        
    }
    else if(([headDto.oiStatus eq:@"R"] ||
             [headDto.oiStatus eq:@"r"] ||
             [headDto.oiStatus eq:@"G"]))
    {//以退货订单
        [self setRButtonsPosiotion:self.listDetailDto];
        
    }
    else
    {
        if(delivertOK == YES)
        {
            
            [self setCButtonsPosiotion:headDto];
        }
        else if(finishAcceptOK == YES)
        {
            
            [self setCButtonsPosiotion:self.listDetailDto];
            
        }
        else if(([headDto.oiStatus eq:@"C"] ||
                 [headDto.oiStatus eq:@"c"] ||
                 [headDto.oiStatus eq:@"D"] ||
                 [headDto.oiStatus eq:@"E"] ||
                 [headDto.oiStatus eq:@"SC"] ||
                 [headDto.oiStatus eq:@"SD"] ||
                 [headDto.oiStatus eq:@"WD"] ||
                 [headDto.oiStatus eq:@"SOMED"] ||
                 [headDto.oiStatus eq:@"F"]) &&
                (finishAcceptOK == NO && delivertOK == NO) )
        {//支付完成订单，已发货订单，收货完成订单
            [self setCButtonsPosiotion:self.listDetailDto ];
        }
    }
    
}

//M1 M2:发货处理中订单
- (void)setM1OrM2ButtonsPosiotion:(MemberOrderNamesDTO *)listDto  WithpolicyDesc:(NSString*)policyDesc
{
    
//    self.payBtn.hidden = YES;
//    self.pingJiaBtn.hidden = YES;
//    self.shaiDanBtn.hidden = YES;
//    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    
    if([listDto.oiStatus hasPrefix:@"M"] && ([policyDesc hasPrefix:L(@"MyEBuy_CashOnDelivery")]||[listDto.ormOrder isEqualToString:@"11601"]))
    {
        
        self.snxpressQueryBtn.hidden = NO;
        
        self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX,self.productImageV.bottom + 15, KNewBtnsWidth, KNewBtnsHeight);
        
//        self.cancelOrderBtn.hidden = YES;
        
//        self.payBtn.hidden = YES;
        
        self.lineView.hidden = YES;
        self.lineTwoView.hidden = NO;
    }
    
    
}



//R:退货成功的订单
- (void)setRButtonsPosiotion:(MemberOrderNamesDTO *)listDto {
//    self.payBtn.hidden = YES;
//    self.pingJiaBtn.hidden = YES;
//    self.shaiDanBtn.hidden = YES;
//    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    
}

//X:已取消的订单
- (void)setXButtonsPosiotion:(MemberOrderNamesDTO *)listDto {
//    self.payBtn.hidden = YES;
//    self.pingJiaBtn.hidden = YES;
//    self.shaiDanBtn.hidden = YES;
//    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    
}

//M:待支付的订单
- (void)setMButtonsPosiotion:(MemberOrderNamesDTO *)listDto WithpolicyDesc:(NSString*)policyDesc
{
//    self.payBtn.hidden = YES;
//    self.pingJiaBtn.hidden = YES;
//    self.shaiDanBtn.hidden = YES;
//    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    //    self.confirmBtn.hidden = YES;
    
    
    if([listDto.oiStatus hasPrefix:@"M"] && ([policyDesc hasPrefix:L(@"MyEBuy_CashOnDelivery")]||[listDto.ormOrder isEqualToString:@"11601"]))
    {
        
        if([listDto.ormOrder isEqualToString:@"11701"] &&  [self.detailDto.currentShipModeType isEqualToString:L(@"MyEBuy_Delivery")])
        {
            //            self.cancelOrderBtn.hidden = NO;
            //            self.snxpressQueryBtn.hidden = NO;
            
            //            self.cancelOrderBtn.frame = CGRectMake(KFirstBigBtnsX, self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
            self.snxpressQueryBtn.hidden = NO;
            
            self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX, self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
            
//            self.payBtn.hidden = YES;
            self.lineView.hidden = YES;
            self.lineTwoView.hidden = NO;
        }
        else
        {
            self.snxpressQueryBtn.hidden = NO;
            
            self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX, self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
            
//            self.cancelOrderBtn.hidden = YES;
            
//            self.payBtn.hidden = YES;
            self.lineView.hidden = YES;
            self.lineTwoView.hidden = NO;
        }
        
    }
    
    
}

//C:已支付的订单
- (void)setCButtonsPosiotion:(MemberOrderNamesDTO *)listDto
{
    
//    self.payBtn.hidden = YES;
//    self.pingJiaBtn.hidden = YES;
//    self.shaiDanBtn.hidden = YES;
//    self.cancelOrderBtn.hidden = YES;
    self.snxpressQueryBtn.hidden = YES;
    self.lineView.hidden = YES;
    self.lineTwoView.hidden = NO;
    
    
    if ( ![_detailDto.isBundle isEqual:@"1"]) {
        
        self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX,self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
        
//        self.pingJiaBtn.hidden = NO;
//        self.pingJiaBtn.frame = CGRectMake(self.snxpressQueryBtn.right+2,self.productImageV.bottom+15, KNewSmallBtnsWidth, KNewBtnsHeight);
//        
//        self.shaiDanBtn.hidden = NO;
//        self.shaiDanBtn.frame = CGRectMake(self.pingJiaBtn.right+2,self.productImageV.bottom+15, KNewSmallBtnsWidth, KNewBtnsHeight);
        
        self.lineView.hidden = YES;
        self.lineTwoView.hidden = NO;
    }
    
    else
    {
        
        self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX,self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
        
//        self.shaiDanBtn.hidden = YES;
//        self.pingJiaBtn.hidden = YES;
        
    }
    
    self.snxpressQueryBtn.hidden = NO;
    
    if(IsStrEmpty(listDto.supplierCode))
    {
        
    }
    else
    {
        
        self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX,self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
        
//        self.shaiDanBtn.hidden = YES;
//        self.pingJiaBtn.hidden = YES;
        
    }
    
    
    if(IsStrEmpty(listDto.supplierCode))
    {
        
    }
    else
    {
        if(self.row != 1 && self.row != 3)
        {
            self.snxpressQueryBtn.hidden = YES;
            self.lineView.hidden = NO;
            self.lineTwoView.hidden = YES;
        }
        if ([self.logisticsShowReference eq:@"1"]) {
            self.snxpressQueryBtn.hidden = NO;
        }
    }
    
    
}

//row 0为第一个cell 1为最后一个cell 2为中间cell 3为只有一个cell
- (CGFloat)cellH:(MemberOrderNamesDTO *)dto Withrow:(int)row
{
    float cellHeight = 0;
    
    
    if([dto.oiStatus isEqualToString:@"H"] ||
       [dto.oiStatus isEqualToString:@"X"] ||
       [dto.oiStatus isEqualToString:@"r"] ||
       [dto.oiStatus isEqualToString:@"G"] ||
       [dto.oiStatus isEqualToString:@"R"])
    {
        cellHeight = 110;
    }
    else if ([dto.oiStatus isEqualToString:@"r"] ||
             [dto.oiStatus isEqualToString:@"X"] ||
             [dto.oiStatus isEqualToString:@"R"] )
    {
        return 110;
    }
    else
    {
        //等待支付订单中的 1.自营商品非货到付款订单只最后一行显示按钮  2.c店商品只最后一行显示按钮  3.有查询物流按钮的订单每行都得显示按钮
        if([dto.oiStatus hasPrefix:@"M"])
        {
            if(IsStrEmpty(dto.supplierCode))
            {
                if([dto.ormOrder isEqualToString:@"11601"])
                {
                    return 163;//自营：货到付款和门店支付订单有按钮行
                    
                }
                else
                {//只最后一行显示按钮
                    
                    cellHeight = 110;
                    
                }
                
            }
            else
            {
                
                cellHeight = 110;
                
                
            }
            
        }
        else if([dto.oiStatus isEqualToString:@"e"])
        {
            return 110;
        }
        else
        {
            
            if(IsStrEmpty(dto.supplierCode))
            {
                return 163;
            }
            else
            {
                
                //c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                if(row == 1 || row == 3)
                {
                    return 163;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行
                    
                }
                else
                {
                    return 110;//c店：一个订单同一家c店商品在该店最后一个商品显示按钮行，其余不显示
                }
                
            }
            
        }
        
    }
    
    
    
    if(cellHeight == 110)
    {
        self.lineView.hidden = NO;
        self.lineTwoView.hidden = YES;
//        self.payBtn.hidden = YES;
//        self.cancelOrderBtn.hidden = YES;
    }
    else  if(cellHeight == 163)
    {
        self.lineView.hidden = YES;
        self.lineTwoView.hidden = NO;
        
    }
    
    return cellHeight;
}

//row 0为第一个cell 1为最后一个cell 2为中间cell 3为只有一个cell
+ (CGFloat)orderProInfoNewCellHeight:(MemberOrderNamesDTO *)dto Withrow:(int)row
{
    if(dto == nil)
    {
        return 0;
    }
    
    return [[[NewOrderProInfoCell alloc] init] cellH:dto Withrow:row];
}

#pragma mark -
#pragma 门店订单
- (void)setShopDetailProInfoCellInfo:(ShopDetailDto *)detailDto
                         WithHeadDto:(ShopDetailItemDto *)itemDto
                        WithPosition:(NSInteger)cellRow
{
    if(IsNilOrNull(detailDto) || IsNilOrNull(itemDto))
    {
        return;
    }
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:itemDto.commodityCode size:ProductImageSize160x160];
    }
    else{
        
        self.productImageV.imageURL = [ProductUtil getImageUrlWithProductCode:itemDto.commodityCode size:ProductImageSize120x120];
    }
    
    
    self.productNameLbl.text = itemDto.commodityName;
    
    self.shopContextLbl.text = L(@"MyEBuy_SuningSelf");
    
    self.productNumLbl.text =[NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[itemDto.saleCount intValue]] ;
    
    NSString *marketPrice = [NSString stringWithFormat:@"%.2f",[itemDto.unitPrice floatValue]];
    
    self.productPriceContextLbl.text = marketPrice;
    
    self.productImageV.frame = CGRectMake(KNewProOriginX, 15, 85, 85);
    
    int nameLines = [self setProNameHeight:itemDto.commodityName WithLbl:self.productNameLbl];
    
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.productImageV.right+10, 16, 190, 15);
        self.productPriceContextLbl.frame = CGRectMake(self.productImageV.right+10, 55, 100, 20);
        
        self.productNumLbl.frame = CGRectMake(_productPriceContextLbl.right+10, 55, 85, 20);
        
        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.productImageV.right+10, 10, 190, 40);
        self.productPriceContextLbl.frame = CGRectMake(self.productImageV.right+10, 55, 100, 20);
        
        self.productNumLbl.frame = CGRectMake(_productPriceContextLbl.right+10, 55, 85, 20);
        
    }
    
    //    self.accessView.frame = CGRectMake(300, 52, 8, 15);
    
    self.accessView.hidden = YES;
    self.shopContextLbl.frame = CGRectMake(self.productImageV.right+10, _productNumLbl.bottom, 180, 20);
    
    self.lineView.hidden = YES;
    self.lineTwoView.hidden = YES;
    
    self.lineView.frame = CGRectMake(0, 109.5, 320, 0.5);
    self.lineTwoView.frame = CGRectMake(0, 162.5, 320, 0.5);
    
    
    [self setShopOrderAButtonsPosiotion];
    
}


//ALL:全部订单
- (void)setShopOrderAButtonsPosiotion
{
    
    self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX, self.productImageV.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
    
    self.snxpressQueryBtn.hidden = NO;
    
}


#pragma mark - 生活团购订单详情
- (void)setGroupOrderDetailCell:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.productImageV.hidden = YES;
    
    CGFloat nameSizeHeight = [self lblNumberOfLines:self.productNameLbl.font WithLbl:dto.snProName WithLblWidth:290];
    
    self.productNameLbl.frame = CGRectMake(KNewCellOrigionX, 10, 290, nameSizeHeight);
    
    self.productNameLbl.text = dto.snProName?dto.snProName:@"";
    
    self.productPriceContextLbl.font = [UIFont systemFontOfSize:12];
    self.productPriceContextLbl.frame = CGRectMake(KNewCellOrigionX, self.productNameLbl.bottom+7, 260, 13);
    self.productPriceContextLbl.text = [NSString stringWithFormat:@"¥%@",dto.orderAmount?dto.orderAmount:@""];
    self.productPriceContextLbl.textAlignment = UITextAlignmentRight;
    
    self.productNumLbl.font = [UIFont systemFontOfSize:12];
    self.productNumLbl.frame = CGRectMake(KNewCellOrigionX, self.productNameLbl.bottom+7, 290, 13);
    self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[dto.saleCount intValue]];
    self.productNumLbl.textAlignment = UITextAlignmentLeft;
    
    
    self.shopContextLbl.hidden = YES;
    
    self.accessView.frame = CGRectMake(300, (nameSizeHeight+42.5)/2-5, 8, 15);
    
    self.lineView.hidden = NO;
    self.lineView.frame = CGRectMake(0, nameSizeHeight+42.5, 320, 0.5);
    self.lineTwoView.hidden = YES;
    
}

- (void)cShopOrderLine:(MemberOrderDetailsDTO *)dto isCShopList:(BOOL)cShopList
{
    if ([dto.isconfirmReceipt isEqualToString:@"true"] && cShopList == YES) {
        self.lineView.hidden = YES;
        self.lineTwoView.hidden = YES;
        self.lineView2.frame = CGRectMake(0, 162.5, 320, 0.5);
        [self.contentView addSubview:self.lineView2];
    }
    else if (dto.isconfirmReceipt == nil && cShopList == YES)
    {
        self.lineView.hidden = YES;
        self.lineTwoView.hidden = YES;
        self.lineView3.frame = CGRectMake(0, 109.5, 320, 0.5);
        [self.contentView addSubview:self.lineView3];
        
    }
    
}


+ (CGFloat)setGroupOrderDetailCellHeight:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return 0;
    }
    
    CGFloat nameSizeHeight = [[NewOrderProInfoCell alloc] lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.snProName WithLblWidth:290];
    
    
    return nameSizeHeight+43;
    
}




@end
